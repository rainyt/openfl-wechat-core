import lime.utils.ObjectPool;
import wx.WxImage;

@:expose
class HTMLImageElement extends HTMLElement {
	public static var IMAGE_COUNT:Int = 0;

	#if pool_use
	private static var IMAGE_POOL:ObjectPool<WxImage> = new ObjectPool(() -> {
		return Wx.createImage();
	}, (img) -> {
		img.onload = null;
		img.onerror = null;
		img.src = "";
		img = null;
	});
	#end
	
	private var _contextImage:WxImage;

	private var _width:Float;

	private var _height:Float;

	public function new() {
		super("IMG");
		if (untyped window.wxdebug)
			trace("create canvas IMAGE_COUNT=", IMAGE_COUNT);
		// 重定义src方法
		HTMLUtils.definePropertySetGet(this, "src", set_src, get_src);
		HTMLUtils.definePropertySetGet(this, "width", set_width, get_width);
		HTMLUtils.definePropertySetGet(this, "height", set_height, get_height);
	}

	private function createImage():Void {
		if (_contextImage != null)
			return;
		IMAGE_COUNT++;
		untyped window.imageCount = IMAGE_COUNT;
		#if pool_use
		_contextImage = IMAGE_POOL.get();
		#else
		_contextImage = Wx.createImage();
		#end
		_contextImage.onload = function() {
			width = _contextImage.width;
			height = _contextImage.height;
			triggerEvent("load");
			#if bili
			_contextImage.onerror = null;
			#end
			// disposeImage();
		};
		_contextImage.onerror = function(err) {
			triggerEvent("error");
		};
	}

	/**
	 * 释放图片载入
	 */
	public function disposeImage():Void {
		if (_contextImage != null) {
			IMAGE_COUNT--;
			untyped window.imageCount = IMAGE_COUNT;
			if (untyped window.wxdebug)
				trace("delete canvas IMAGE_COUNT=", IMAGE_COUNT, _contextImage.src);
			#if pool_use
			IMAGE_POOL.release(_contextImage);
			#else
			_contextImage.onload = null;
			_contextImage.onerror = null;
			_contextImage.src = "";
			#end
			_contextImage = null;
		}
	}

	/**
	 * 旧版本的微信API，不支持更改宽度
	 * @param f 
	 * @return Float
	 */
	public function set_width(f:Float):Float {
		_width = f;
		return f;
	}

	public function get_width():Float {
		return _width;
	}

	/**
	 * 旧版本的微信API，不支持更改高度
	 * @param f 
	 * @return Float
	 */
	public function set_height(f:Float):Float {
		_height = f;
		return f;
	}

	public function get_height():Float {
		return _height;
	}

	/**
	 * src
	 */
	public var src:String = null;

	private var _src:String = null;

	private function set_src(path:String):String {
		HTMLUtils.ofPathNoSync(path, function(path) {
			if (path.indexOf("data:") == 0 || path.indexOf(HTMLUtils.START) != -1 || path.indexOf("photo://") != -1) {
				_src = path;
				#if unbase64image
				if (path.indexOf("data:") == 0) {
					path = path.substr(path.indexOf("base64,") + 7);
					var localPath:String = HTMLUtils.ofLocalPath(path);
					Wx.getFileSystemManager().writeFile({
						filePath: localPath,
						data: path,
						encoding: "base64",
						success: function(e:Dynamic):Void {
							// _contextImage.src = localPath;
							createImage();
							_contextImage.src = "https://static.kdyx.cn/sxkbaoxiao/1051/1px.png";
						},
						fail: function(e:Dynamic) {
							trace("base64图片储存失败！", e);
						}
					});
					return;
				}
				#end
				if (path.indexOf("photo://") == -1)
					_src = StringTools.replace(_src, HTMLUtils.START, "");
				else
					_src = StringTools.replace(_src, "photo://", HTMLUtils.START);
				createImage();
				_contextImage.src = _src;
			} else {
				// 二进制路径使用binary
				if (!HTMLUtils.cacheAssets(path, "binary", function(data:Dynamic):Void {
					createImage();
					_src = data;
					_contextImage.src = data;
				}, function():Void {
					createImage();
					// triggerEvent("error");
					// 当本地无法缓存的情况下，使用网络地址载入
					_src = path;
					_contextImage.src = path;
				}, true)) {
					_src = path;
					createImage();
					_contextImage.src = path;
				}
			}
		});
		return _src;
	}

	private function get_src():String {
		return _src;
	}
}
