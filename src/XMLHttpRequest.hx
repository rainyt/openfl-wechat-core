@:expose
class XMLHttpRequest extends EventElement {
	// TODO 没法模拟 HEADERS_RECEIVED 和 LOADING 两个状态
	public static var UNSEND:Int = 0;
	public static var OPENED:Int = 1;
	public static var HEADERS_RECEIVED:Int = 2;
	public static var LOADING:Int = 3;
	public static var DONE:Int = 4;

	/**
	 * 基础事件列表
	 */
	public var onabort:Dynamic = null;

	public var onloadstart:Dynamic = null;
	public var onloadend:Dynamic = null;
	public var onreadystatechange:Dynamic = null;
	public var readyState:Int = 0;
	public var response:Dynamic;
	public var responseText:String;
	public var responseXML:Dynamic;
	public var url:String;
	public var method:String;
	public var status:Int;

	public var upload:UploadElement;

	/**
	 * 请求头信息
	 */
	private var _requestHeader:Map<String, String> = new Map<String, String>();

	/**
	 * 请求路径
	 */
	public var responseType:String = "text";

	public function new() {
		super();
		upload = new UploadElement();
		// 默认头
		_requestHeader.set("content-type", "application/x-www-from-urlencoded");
	}

	/**
	 * 访问API
	 * @param method GET/POST
	 * @param url 网址
	 * @param async 是否异步
	 * @param username 用户名 未实现
	 * @param password 密码 未实现
	 */
	public function open(method:String, url:String, async:Bool, username:String = null, password:String = null) {
		this.method = method;
		this.url = url;
		this.changeReadyState(OPENED);
	}

	/**
	 * XMLHttpRequest 的 overrideMimeType 方法是指定一个MIME类型用于替代服务器指定的类型，使服务端响应信息中传输的数据按照该指定MIME类型处理。例如强制使流方式处理为"text/xml"类型处理时会被使用到，即使服务器在响应头中并没有这样指定。此方法必须在send方法之前调用方为有效。
	 * @param type 指定具体的MIME类型去代替有服务器指定的MIME类型. 如果服务器没有指定类型，那么 XMLHttpRequest 将会默认为 "text/xml"
	 */
	public function overrideMimeType(type:String):Void {
		// 未实现
	}

	/**
	 * XMLHttpRequest.setRequestHeader() 是设置HTTP请求头部的方法。此方法必须在  open() 方法和 send()   之间调用。如果多次对同一个请求头赋值，只会生成一个合并了多个值的请求头。
	 */
	public function setRequestHeader(header:String, value:String):Void {
		// TODO 应该不需要转小写，由服务器自主识别完成
		_requestHeader.set(header, value);
	}

	/**
	 * 方法用于发送 HTTP 请求。如果是异步请求（默认为异步请求），则此方法会在请求发送后立即返回；如果是同步请求，则此方法直到响应到达后才会返回。XMLHttpRequest.send() 方法接受一个可选的参数，其作为请求主体；如果请求方法是 GET 或者 HEAD，则应将请求主体设置为 null。
	 * @param data 
	 */
	public function send(data:Dynamic = null):Void {
		HTMLUtils.ofPathNoSync(this.url, function(path) {
			this.url = path;
			// 支持arraybuffer_path处理
			var isCallBackPath:Bool = false;
			if (this.url.indexOf("__zygameui.bitmap.path__") != -1) {
				this.url = StringTools.replace(this.url, "__zygameui.bitmap.path__", "");
				isCallBackPath = true;
			}
			var isCanCache:Bool = HTMLUtils.cacheAssets(this.url, this.responseType == "arraybuffer" ? "binary" : "utf8", function(res:Dynamic):Void {
				// 读取成功，读取资源
				if (isCallBackPath) {
					onSuccess({
						statusCode: 200,
						data: res
					});
				} else {
					res.statusCode = 200;
					onSuccess(res);
				}
			}, function():Void {
				onFail();
				// triggerEvent("error");
				// sendRequest(data);
			}, isCallBackPath);
			if (!isCanCache)
				sendRequest(data);
		});
	}

	private function sendRequest(data:Dynamic = null):Void {
		var header:Dynamic = {};
		var keys:Iterator<String> = _requestHeader.keys();
		while (keys.hasNext()) {
			var key:String = keys.next();
			Reflect.setProperty(header, key, _requestHeader.get(key));
		}

		// #if qqquick
		// if(Window.platform == "android")
		//     data = HTMLUtils.arrayBufferToString(data);
		// #else
		if (data != null && !Std.is(data, String))
			data = HTMLUtils.arrayBufferToString(data);
		// #end

		var requestData:Dynamic = {
			url: url,
			method: method,
			header: header,
			timeout: 6000, // 3秒超时
			responseType: responseType,
			success: onSuccess,
			fail: function(e) {
				trace("wechat fail:", url, e);
				onFail();
			},
			dataType: "unjson"
		};

		if (data != null)
			requestData.data = data;
		Wx.request(requestData);
		triggerEvent("loadstart");
		changeReadyState(HEADERS_RECEIVED);
		changeReadyState(LOADING);
	}

	private function onSuccess(data:Dynamic):Void {
		// trace("success",this.url,data.data);
		this.status = data.statusCode;
		if (!HTMLUtils.isArrayBuffer(data.data)) {
			// 字符串
			if (!HTMLUtils.isString(data.data)) {
				this.response = haxe.Json.stringify(data.data);
				this.responseText = this.response;
			} else {
				this.response = data.data;
				this.responseText = data.data;
			}
		} else {
			if (responseType == "text") {
				// 二进制
				this.response = HTMLUtils.arrayBufferToString(data.data);
				this.responseText = this.response;
			} else {
				// 二进制
				this.response = data.data;
				this.responseText = null;
			}
		}
		changeReadyState(DONE);
		triggerEvent("load");
		triggerEvent("loadend");
	}

	/**
	 * 加载失败
	 */
	private function onFail():Void {
		changeReadyState(DONE);
		triggerEvent("error");
	}

	/**
	 * 统一更换准备状态
	 * @param state 
	 * @param event 
	 */
	private function changeReadyState(state:Int, event:Dynamic = null):Void {
		// 已经DONE则不再回调
		if (this.readyState == DONE)
			return;
		this.readyState = state;
		if (event == null)
			event = {};
		event.readyState = readyState;
		triggerEvent("readystatechange", event);
	}

	/**
	 * XMLHttpRequest.getAllResponseHeaders() 方法返回所有的响应头，以 CRLF 分割的字符串，或者 null 如果没有收到任何响应。 注意： 对于复合请求 （ multipart requests ），这个方法返回当前请求的头部，而不是最初的请求的头部。
	 * @return Dynamic
	 */
	public function getAllResponseHeaders():Dynamic {
		var arr:Array<String> = [];
		var keys:Iterator<String> = _requestHeader.keys();
		while (keys.hasNext()) {
			var key:String = keys.next();
			arr.push(key + ":" + _requestHeader.get(key));
		}
		return arr.join("\n");
	}
}
