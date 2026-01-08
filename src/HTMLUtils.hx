import haxe.io.Path;
import js.Syntax;

class HTMLUtils {
	public static var START:String = #if tt "ttfile://" #elseif baidu "bdfile://" #else "wxfile://" #end;

	/**
	 * 判断是否二进制类型
	 * @param data 
	 * @return Bool
	 */
	public static function isArrayBuffer(data:Dynamic):Bool {
		return Syntax.code("data instanceof ArrayBuffer");
	}

	/**
	 * 定义一个set/get的属性变量
	 */
	public static function definePropertySetGet(obj:Dynamic, key:String, set:Dynamic, get:Dynamic):Void {
		Syntax.code("
        Object.defineProperty(obj, key, {
            enumerable: true,
            configurable: true,
            set: set,
            get: get
        })");
	}

	/**
	 * 判断是否为字符串
	 * @param data 
	 * @return Bool
	 */
	public static function isString(data:Dynamic):Bool {
		return Syntax.code("typeof data === 'string'");
	}

	/**
	 * 转换地址
	 * @param path 
	 * @return String
	 */
	public static function ofPathNoSync(path:String, cb:String->Void):Void {
		// 网址处理，异步不太稳定，改成同步
		cb(ofPath(path));
		// isLocalAssetsNoSync(path, function(bool) {
		// 	if (path.indexOf("data:image") == 0
		// 		|| (path.indexOf("http") == 0 && !bool)
		// 		|| path.indexOf(START) != -1
		// 		|| path.indexOf("photo://") != -1) {
		// 		cb(path);
		// 	} else if (untyped window.webPath == null || bool) {
		// 		// 如果已经带有http远程路径
		// 		if (path.indexOf(untyped window.webPath + "/") == 0)
		// 			path = StringTools.replace(path, untyped window.webPath + "/", "");
		// 		if (path.indexOf(START) == -1)
		// 			path = START + path;
		// 		if (path.indexOf("?") != -1)
		// 			path = path.substr(0, path.lastIndexOf("?"));
		// 	} else {
		// 		path = untyped window.webPath + "/" + path;
		// 	}
		// 	cb(path);
		// });
	}

	/**
	 * 转换地址
	 * @param path 
	 * @return String
	 */
	public static function ofPath(path:String):String {
		// 网址处理
		if (path.indexOf("data:image") == 0
			|| (path.indexOf("http") == 0 && !isLocalAssets(path))
			|| path.indexOf(START) != -1
			|| path.indexOf("photo://") != -1) {
			return path;
		} else if (untyped window.webPath == null || isLocalAssets(path)) {
			// 如果已经带有http远程路径
			if (path.indexOf(untyped window.webPath + "/") == 0)
				path = StringTools.replace(path, untyped window.webPath + "/", "");
			if (path.indexOf(START) == -1)
				path = Path.join([START, path]);
			if (path.indexOf("?") != -1)
				path = path.substr(0, path.lastIndexOf("?"));
		} else {
			path = Path.join([untyped window.webPath, path]);
		}
		return path;
	}

	/**
	 * 非同步检索是否存在本地资源
	 * @param path 检查路径
	 * @return Bool
	 */
	public static function isLocalAssetsNoSync(path:String, cb:Bool->Void):Void {
		#if baidu
		cb(false);
		#end
		if (path.indexOf(untyped window.webPath + "/") == 0)
			path = StringTools.replace(path, untyped window.webPath + "/", "");
		if (path.indexOf("http") == 0)
			cb(false);
		// 本地路径不需要加bdfile://
		// if(path.indexOf(START) == -1)
		//     path = START + path;
		if (path.indexOf("?") != -1)
			path = path.substr(0, path.lastIndexOf("?"));
		// try {
		// 	Wx.getFileSystemManager().accessSync(path);
		// 	cb(true);
		// } catch (e:Dynamic) {
		// 	cb(false);
		// }
		Wx.getFileSystemManager().access({
			path: path,
			success: function(res) {
				// 文件存在
				cb(true);
			},
			fail: function(res) {
				// 文件不存在或其他错误
				cb(false);
			}
		});
	}

	/**
	 * 是否存在本地资源
	 * @param path 检查路径
	 * @return Bool
	 */
	public static function isLocalAssets(path:String):Bool {
		#if baidu
		return false;
		#end
		if (path.indexOf(untyped window.webPath + "/") == 0)
			path = StringTools.replace(path, untyped window.webPath + "/", "");
		if (path.indexOf("http") == 0)
			return false;
		// 本地路径不需要加bdfile://
		// if(path.indexOf(START) == -1)
		//     path = START + path;
		if (path.indexOf("?") != -1)
			path = path.substr(0, path.lastIndexOf("?"));
		try {
			Wx.getFileSystemManager().accessSync(path);
			return true;
		} catch (e:Dynamic) {
			return false;
		}
	}

	/**
	 * 本地路径
	 * @param path 
	 * @return String
	 */
	public static function ofLocalPath(path:String):String {
		var localPath:String = Wx.env.USER_DATA_PATH + "/" + haxe.crypto.Md5.encode(path);
		return localPath;
	}

	/**
	 * 可缓存的格式 ["png","json","bin","xml","mp3","jpg","zip"]
	 */
	private static var cacheExt:Array<String> = #if qihoo ["png", "mp3", "jpg", "zip"] #elseif (baidu || qq) ["png", "mp3", "jpg"] #else ["png", "json", "mp3", "xml", "jpg"] #end;

	/**
	 * 是否允许缓存，当缓存超过指定大小时，将不再允许缓存
	 */
	private static var _isCanCache:Bool = true;

	/**
	 * 用于映射临时文件的地址
	 */
	private static var tempFileMaps:Map<String, String> = new Map<String, String>();

	/**
	 * 统一的缓存入口，该接口会判断本地资源是否存在，当不存在的时候，会进行网络下载到本地，如果下载失败，则返回到上级
	 * @param path 
	 * @param callLocalPath 这里设置为true，成功回调将会返回地址路径，并且会尝试下载到本地临时文件中
	 * @return Bool 这里如果返回的是false，则意味着资源不可被缓存
	 */
	public static function cacheAssets(path:String, encoding:String, success:Dynamic->Void, fail:Void->Void, callLocalPath:Bool = false):Bool {
		// 是否本地资源
		if (path.indexOf(START) == 0) {
			path = StringTools.replace(path, START, "");
			if (callLocalPath) {
				success(path);
				return true;
			}
			var obj:Dynamic = {
				filePath: path,
				success: function(res:Dynamic):Void {
					success(res);
				},
				fail: function():Void {
					fail();
				}
			};
			if (encoding == "binary") {
				encoding = null;
			} else
				obj.encoding = encoding;
			Wx.getFileSystemManager().readFile(obj);
			return true;
		}
		#if (uncache)
		// QQ轻游戏、百度小游戏对这个支持有缺陷
		return false;
		#end
		// 当缓存已被下载到临时目录之下，并需要返回本地路径的载入时，可直接返回本地临时文件路径
		if (tempFileMaps.exists(path)) {
			if (callLocalPath)
				success(tempFileMaps.get(path));
			else {
				if (encoding == "binary") {
					encoding = null;
				}
				Wx.getFileSystemManager().readFile({
					filePath: tempFileMaps.get(path),
					encoding: encoding,
					success: function(res:Dynamic):Void {
						success(res);
					},
					fail: function(res:Dynamic):Void {
						trace("临时文件读取失败：", res);
						fail();
					}
				});
			}
			return true;
		}
		if (path.indexOf("http") != 0)
			return false;
		var isCanCache:Bool = false;
		for (c in cacheExt) {
			if (path.indexOf(c) != -1) {
				isCanCache = true;
				break;
			}
		}
		// 不能进行缓存的类型
		if (!isCanCache)
			return false;
		// 下载到临时文件
		downloadTempFile(path, function(res:Dynamic):Void {
			if (callLocalPath) {
				success(res);
			} else {
				// 读取该文件
				if (encoding == "binary") {
					encoding = null;
				}
				Wx.getFileSystemManager().readFile({
					filePath: tempFileMaps.get(path),
					encoding: encoding,
					success: function(res:Dynamic):Void {
						success(res);
					},
					fail: function(res):Void {
						trace("临时文件读取失败-2：", res);
						fail();
					}
				});
			}
		}, fail);
		return true;
	}

	/**
	 * 将ArrayBuffer转为字符串
	 * @param data 
	 * @return String
	 */
	public static function arrayBufferToString(arrayBuffer:Dynamic):String {
		if (isArrayBuffer(arrayBuffer)) {
			Syntax.code(' var result = "";
		  var i = 0;
		  var c = 0;
		  var c1 = 0;
		  var c2 = 0;
		  var c3 = 0;

		  var data = new Uint8Array(arrayBuffer);

		  // If we have a BOM skip it
		  if (data.length >= 3 && data[0] === 0xef && data[1] === 0xbb && data[2] === 0xbf) {
		    i = 3;
		  }

		  while (i < data.length) {
		    c = data[i];

		    if (c < 128) {
		      result += String.fromCharCode(c);
		      i++;
		    } else if (c > 191 && c < 224) {
		      if( i+1 >= data.length ) {
		        throw "UTF-8 Decode failed. Two byte character was truncated.";
		      }
		      c2 = data[i+1];
		      result += String.fromCharCode( ((c&31)<<6) | (c2&63) );
		      i += 2;
		    } else {
		      if (i+2 >= data.length) {
		        throw "UTF-8 Decode failed. Multi byte character was truncated.";
		      }
		      c2 = data[i+1];
		      c3 = data[i+2];
		      result += String.fromCharCode( ((c&15)<<12) | ((c2&63)<<6) | (c3&63) );
		      i += 3;
		    }
		  }
		  return result;');
		}
		return arrayBuffer;
	}

	/**
	 * 下载临时文件
	 * @param path 下载地址
	 * @param cb 成功接口
	 * @param fail 失败接口
	 */
	public static function downloadTempFile(path:String, success:Dynamic->Void, fail:Void->Void):Void {
		// 下载资源保存到本地
		Wx.downloadFile({
			url: path,
			timeout: 60000,
			enableHttp2: true,
			success: function(res:Dynamic):Void {
				var value = res.tempFilePath;
				if (value == null || value == "") {
					downloadTempFile(path, success, fail);
				} else {
					// 新增临时文件路径的映射处理
					tempFileMaps.set(path, value);
					success(res.tempFilePath);
				}
			},
			fail: function(data:Dynamic) {
				// 临时文件无法下载，意味着资源无法被下载
				trace("wx.donwloadFile fail:", path, data);
				fail();
			}
		});
	}
}
