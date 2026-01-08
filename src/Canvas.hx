import lime.utils.ObjectPool;
import haxe.Exception;
import haxe.Json;

@:expose
class Canvas extends HTMLCanvasElement {
	public static var CANVAS_COUNT:Int = 0;

	#if pool_use
	private static var CANVAS_POOL:ObjectPool<Dynamic> = new ObjectPool(() -> {
		return Wx.createCanvas();
	}, (img) -> {});
	#end

	private var _wxCanvas:Dynamic;

	private var _context2d:Dynamic;

	private var _gl:Dynamic;

	public function new() {
		super("CANVAS");
		#if OPENDATA_ENGINE
		if (untyped window.getSharedCanvas == null) {
			untyped window.getSharedCanvas = true;
			_wxCanvas = Wx.getSharedCanvas();
		} else
			_wxCanvas = Wx.createCanvas();
		#else
		#if mgc
		if (Wx.ext_createCanvas != null)
			_wxCanvas = Wx.ext_createCanvas();
		else
			_wxCanvas = Wx.createCanvas();
		#else
		#if pool_use
		_wxCanvas = CANVAS_POOL.get();
		#else
		_wxCanvas = Wx.createCanvas();
		#end
		CANVAS_COUNT++;
		if (untyped window.wxdebug)
			trace("CANVAS_COUNT=", CANVAS_COUNT);
		#end
		#end
		HTMLUtils.definePropertySetGet(this, "width", set_width, get_width);
		HTMLUtils.definePropertySetGet(this, "height", set_height, get_height);
		this.width = _wxCanvas.width;
		this.height = _wxCanvas.height;
	}

	/**
	 * 清理内部引用
	 */
	public function cleanup():Void {
		// CanvasPool.put(this);
		if (_wxCanvas != null) {
			#if pool_use
			CANVAS_POOL.release(_wxCanvas);
			#end
			_wxCanvas = null;
			CANVAS_COUNT--;
			if (untyped window.wxdebug)
				trace("CANVAS_COUNT=", CANVAS_COUNT);
		}
		if (_context2d != null) {
			_context2d.cleanup();
			_context2d = null;
		}
		_gl = null;
		// GC.cleanup();
	}

	public function getAttribute(key:String):Dynamic {
		return "";
	}

	public function setAttribute(key:String, value:Dynamic) {}

	public function set_width(f:Float):Float {
		if (_wxCanvas == null)
			return 0;
		_wxCanvas.width = f;
		clientWidth = f;
		return f;
	}

	public function get_width():Float {
		if (_wxCanvas == null)
			return 0;
		return _wxCanvas.width;
	}

	public function set_height(f:Float):Float {
		if (_wxCanvas == null)
			return 0;
		_wxCanvas.height = f;
		clientHeight = f;
		return f;
	}

	public function get_height():Float {
		if (_wxCanvas == null)
			return 0;
		return _wxCanvas.height;
	}

	public function toTempFilePath(data:Dynamic):Void {
		_wxCanvas.toTempFilePath(data);
	}

	public function toTempFilePathSync(data:Dynamic):String {
		return _wxCanvas.toTempFilePathSync(data);
	}

	public function getContext(type:String):Dynamic {
		// 不支持webgl2上下文
		if (type != "2d")
			type = "webgl";
		if (type == "2d") {
			if (_context2d == null) {
				_context2d = new Context2d(_wxCanvas.getContext(type));
				_context2d._canvas = _wxCanvas;
			}
			return _context2d;
		} else {
			#if OPENDATA
			// OPENDATA开放域环境下不支持WEBGL
			return null;
			#else
			// 重定义webgl方法
			if (_gl == null) {
				#if weixin
				if (Window.platform == "ios") {
					if (untyped GameGlobal.isIOSHighPerformanceMode) {
						trace("高性能模式");
						_gl = _wxCanvas.getContext(type, {antialias: true, stencil: true, vsync: true});
						_gl.antialias = true; // 抗锯齿
					} else {
						trace("普通性能模式");
						_gl = _wxCanvas.getContext(type, {antialias: false, vsync: true});
						_gl.antialias = false; // 抗锯齿
					}
				} else {
					_gl = _wxCanvas.getContext(type, {antialias: true, stencil: true, vsync: true});
					_gl.antialias = true; // 抗锯齿
				}
				#else
				_gl = _wxCanvas.getContext(type, {antialias: true, stencil: true, vsync: true});
				_gl.antialias = true; // 抗锯齿
				#end
				// _gl.stencil = true; // 微信小游戏应默认开启
				varWebGLRenderingContext2D(_gl);
			}
			var attributes = _gl.getContextAttributes();
			trace("attributes=", attributes);
			try {
				trace("attributes2=", Json.stringify(attributes));
			} catch (e:Exception) {}
			return _gl;
			#end
		}
	}

	public function putImageData():Void {}

	/**
	 * 重新定义WebGLRenderingContext2D渲染方法
	 * @param gl 
	 */
	private function varWebGLRenderingContext2D(gl:Dynamic):Void {
		if (gl == null)
			return;
		// 实现渲染支持
		var getExtension:Dynamic = gl.getExtension;
		gl.getExtension = function() {
			js.Syntax.code("
				return getExtension.apply(this, arguments);
			");
		}
		var texImage2D:Dynamic = gl.texImage2D;
		#if meituan
		gl.texImage2D = function() {
			js.Syntax.code("
				try {
					var imgContext = null;
					if(arguments.length == 6)
					{
						if(arguments[5] == null)
						{
							console.log('无法渲染');
							return;   
						}
						if(arguments[5]._wxCanvas != null){
							// console.log('渲染_wxCanvas?');
							arguments[5] = arguments[5]._wxCanvas;
						}else if(arguments[5]._contextImage != null){
							// console.log('渲染_contextImage?');
							imgContext = arguments[5];
							arguments[5] = arguments[5]._contextImage;
						}else{
							return;
						}
					}
					// console.log('?arguments.length = ',arguments.length);
					// console.log('?arguments=',arguments[0],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6]);
					// if(arguments[5] != null){
						// console.log(arguments[5]);
					// }
					texImage2D.apply(this,arguments);
				} catch (e) {
					console.log('渲染异常', e.message, e.stack);
				}
            ");
			//
		}
		#else
		// 其他库的默认行为
		gl.texImage2D = function() {
			// try {
			js.Syntax.code("
            var imgContext = null;
            if(arguments.length == 6)
            {
                if(arguments[5] == null)
                {
                    console.log('无法渲染');
                    return;   
                }
                if(arguments[5]._wxCanvas != null){
                    arguments[5] = arguments[5]._wxCanvas;
				}else if(arguments[5]._contextImage != null){
                    imgContext = arguments[5];
                    arguments[5] = arguments[5]._contextImage;
                }else{
					return;
				}
            }
            texImage2D.apply(this,arguments)");
			// GC.cleanup();
			// } catch (e:Dynamic) {
			// 	trace("渲染异常");
			// }
		}
		#end

		var getProgramParameter:Dynamic = gl.getProgramParameter;
		gl.getProgramParameter = function() {
			var value = untyped getProgramParameter.apply(gl, arguments);
			if (value == null) {
				return -1;
			}
			return value;
		}

		#if false
		// 优化API
		uniformFix(gl, "uniform1f");
		uniformFix(gl, "uniform1fv");
		uniformFix(gl, "uniform1i");
		uniformFix(gl, "uniform1iv");
		uniformFix(gl, "uniform2f");
		uniformFix(gl, "uniform2fv");
		uniformFix(gl, "uniform2i");
		uniformFix(gl, "uniform2iv");
		uniformFix(gl, "uniform3f");
		uniformFix(gl, "uniform3fv");
		uniformFix(gl, "uniform3i");
		uniformFix(gl, "uniform3iv");
		uniformFix(gl, "uniform4f");
		uniformFix(gl, "uniform4fv");
		uniformFix(gl, "uniform4i");
		uniformFix(gl, "uniform4iv");
		#end
	}

	private function uniformFix(gl:Dynamic, funName:String):Void {
		var call:Dynamic = Reflect.getProperty(gl, funName);
		if (call != null) {
			Reflect.setProperty(gl, funName, function():Void {
				js.Syntax.code("	
                if(arguments[0] == null){
					// console.warring('gl warring location is null:' + funName);
					throw 'uniformFix:' + funName;
				}
                call.apply(this,arguments)
                ");
			});
		}
	}
}
