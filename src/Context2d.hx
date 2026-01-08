/**
 * 重新实现所有Context2d处理
 */
class Context2d {
	/**
	 * 上下文数量
	 */
	public static var CONTEXT2D_COUNT:Int = 0;

	private var _context:Dynamic;

	private var _size:Int = 0;

	public var _canvas:Dynamic;

	public var canvas(get, never):Dynamic;

	function get_canvas():Dynamic {
		return _canvas;
	}

	public function new(context:Dynamic):Void {
		CONTEXT2D_COUNT++;
		untyped window.contextCount = CONTEXT2D_COUNT;
		_context = context;
		HTMLUtils.definePropertySetGet(this, "globalAlpha", function(value:Dynamic):Void {
			_context.globalAlpha = value;
		}, function():String {
			return _context.globalAlpha;
		});
		HTMLUtils.definePropertySetGet(this, "canvas", function(value:Dynamic):Void {
			_canvas = value;
		}, function():String {
			return _canvas;
		});
		// 重写textAlign支持
		HTMLUtils.definePropertySetGet(this, "textAlign", function(value:String):Void {
			_context.textAlign = value;
		}, function():String {
			return "start";
		});
		HTMLUtils.definePropertySetGet(this, "font", function(value:String):Void {
			var arr:Array<String> = value.split(" ");
			var fontName = value.substr(value.indexOf("'") + 1);
			fontName = fontName.substr(0, fontName.lastIndexOf("'"));
			for (a in arr) {
				if (a.indexOf("px") != -1) {
					// 更新尺寸
					_size = Std.parseInt(a.substr(0, a.lastIndexOf("px")));
					if (a.indexOf("/") != -1)
						a = a.substr(a.indexOf("/") + 1);
					fontName = StringTools.replace(fontName, "/", "");
					fontName = StringTools.replace(fontName, ".", "");
					#if ks
					fontName = "arial";
					#end
					if (fontName.indexOf(" ") != -1)
						fontName = "\"" + fontName + "\"";
					if (fontName.indexOf("px") != -1) {
						_context.font = fontName;
					} else
						_context.font = a + " " + fontName;
					break;
				}
			}
		}, function():String {
			return _context.font;
		});
		HTMLUtils.definePropertySetGet(this, "fillStyle", function(value:String):Void {
			_context.fillStyle = value;
		}, function():String {
			return _context.fillStyle;
		});
		HTMLUtils.definePropertySetGet(this, "textBaseline", function(value:String):Void {
			_context.textBaseline = value;
		}, function():String {
			return _context.textBaseline;
		});
		HTMLUtils.definePropertySetGet(this, "imageSmoothingEnabled", function(value:Bool):Void {
			_context.imageSmoothingEnabled = value;
		}, function():String {
			return _context.imageSmoothingEnabled;
		});
		HTMLUtils.definePropertySetGet(this, "globalCompositeOperation", function(value:Dynamic):Void {
			_context.globalCompositeOperation = value;
		}, function():Dynamic {
			return _context.globalCompositeOperation;
		});
		// lineWidth
		HTMLUtils.definePropertySetGet(this, "lineWidth", function(value:Dynamic):Void {
			_context.lineWidth = value;
		}, function():Dynamic {
			return _context.lineWidth;
		});
		// lineJoin
		HTMLUtils.definePropertySetGet(this, "lineJoin", function(value:Dynamic):Void {
			_context.lineJoin = value;
		}, function():Dynamic {
			return _context.lineJoin;
		});
		// lineCap
		HTMLUtils.definePropertySetGet(this, "lineCap", function(value:Dynamic):Void {
			_context.lineCap = value;
		}, function():Dynamic {
			return _context.lineCap;
		});
		// miterLimit
		HTMLUtils.definePropertySetGet(this, "miterLimit", function(value:Dynamic):Void {
			_context.miterLimit = value;
		}, function():Dynamic {
			return _context.miterLimit;
		});
		// strokeStyle
		HTMLUtils.definePropertySetGet(this, "strokeStyle", function(value:Dynamic):Void {
			_context.strokeStyle = value;
		}, function():Dynamic {
			return _context.strokeStyle;
		});
	}

	/**
	 * 创建径向渐变
	 * @param x0 渐变中心x坐标
	 * @param y0 渐变中心y坐标
	 * @param r0 渐变中心半径
	 * @param x1 渐变结束点x坐标
	 * @param y1 渐变结束点y坐标
	 * @param r1 渐变结束点半径
	 * @return Dynamic
	 */
	public function createRadialGradient(x0, y0, r0, x1, y1, r1):Dynamic {
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.createRadialGradient, args);
	}

	/**
	 * 贝塞尔曲线
	 */
	public function bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.bezierCurveTo, args);
	}

	/**
	 * 清理
	 */
	public function cleanup():Void {
		if (_context != null) {
			CONTEXT2D_COUNT--;
			untyped window.contextCount = CONTEXT2D_COUNT;
		}
		_context = null;
		_canvas = null;
	}

	public function createLinearGradient(a, b, c, d):Dynamic {
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.createLinearGradient, args);
	}

	public function translate(x, y):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.translate, args);
	}

	public function clearRect(x, y, width, height):Void {
		if (_context == null)
			return;
		if (x == null || y == null || width == null || height == null)
			_context.clearRect(0, 0, 0, 0);
		else
			_context.clearRect(x, y, width, height);
	}

	public function createImageData(width:Float, height:Float):Dynamic {
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.createImageData, args);
	}

	public function moveTo(x, y):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.moveTo, args);
	}

	public function lineTo(x, y):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.lineTo, args);
	}

	public function rect(x, y, w, h):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.rect, args);
	}

	public function fillRect(x, y, w, h):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.fillRect, args);
	}

	public function createPattern(texture:Dynamic, type:String):Dynamic {
		var setTexture:Dynamic = null;
		if (texture._wxCanvas != null) {
			setTexture = texture._wxCanvas;
		} else if (texture._contextImage != null) {
			setTexture = texture._contextImage;
		}
		return setTexture == null ? null : _context.createPattern(setTexture, type);
	}

	public function quadraticCurveTo(a:Dynamic, b:Dynamic, c:Dynamic, d:Dynamic):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.quadraticCurveTo, args);
	}

	public function getImageData(a, b, c, d):Dynamic {
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.getImageData, args);
	}

	public function putImageData(a, b, c):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.putImageData, args);
	}

	public function setImageData():Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.setImageData, args);
	}

	public function drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight):Void {
		if (image._contextImage != null)
			image = untyped image._contextImage;
		else if (image._wxCanvas != null)
			image = untyped image._wxCanvas;
		this._context.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight);
	}

	public function beginPath():Void {
		_context.beginPath();
	}

	public function closePath():Void {
		_context.closePath();
	}

	public function fill():Void {
		_context.fill();
	}

	public function stroke(path):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.stroke, args);
	}

	public function fillText(text, x, y):Void {
		_context.fillText(text, x, y);
	}

	public static var __measureTextSizeMaps:Map<String, Int> = [];

	public function measureText(text:String):Dynamic {
		var w = 0;
		for (i in 0...text.length) {
			var char = text.charAt(i);
			var key = _size + "_" + char;
			if (!__measureTextSizeMaps.exists(key)) {
				var data = _context.measureText(char);
				if (data == null) {
					__measureTextSizeMaps.set(key, 0);
				} else {
					__measureTextSizeMaps.set(key, data.width);
				}
			}
			w += __measureTextSizeMaps.get(key);
		}
		return {width: w};
	}

	public function transform(t1, t2, t3, t4, dx, dy):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.transform, args);
	}

	public function save():Void {
		_context.save();
	}

	public function clip():Void {
		_context.clip();
	}

	public function restore():Void {
		_context.restore();
	}

	public function setTransform(a, b, c, d, e, f):Void {
		if (_context != null && _context.setTransform != null)
			_context.setTransform(a, b, c, d, e, f);
	}

	public function isPointInStroke(a, b, c):Bool {
		#if (ks || meituan)
		return false;
		#else
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.isPointInStroke, args);
		#end
	}

	public function isPointInPath(a, b, c, d):Bool {
		#if (ks || meituan)
		return false;
		#else
		var args:Array<Dynamic> = untyped arguments;
		return Reflect.callMethod(_context, _context.isPointInPath, args);
		#end
	}

	public function arc(x, y, radius, startAngle, endAngle, anticlockwise):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.arc, args);
	}

	public function arcTo(x1, y1, x2, y2, radius):Void {
		var args:Array<Dynamic> = untyped arguments;
		Reflect.callMethod(_context, _context.arcTo, args);
	}
}
