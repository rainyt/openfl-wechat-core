import wx.WxWebSocket;

@:expose
class WebSocket {
	public static var CONNECTING = 0;

	public static var OPEN = 1;

	public static var CLOSING = 2;

	public static var CLOSED = 3;

	public var binaryType:String = "";

	public var bufferedAmount:Int = 0;

	public var extensions = '';

	public var onclose:Dynamic = null;

	public var onerror:Dynamic = null;

	public var onmessage:Dynamic = null;

	public var onopen:Dynamic = null;

	public var readyState:Int = 3;

	private var _baseSocket:WxWebSocket;

	public function new(url:String, protocols:Dynamic) {
		if (!Std.is(url, String) || url == null || url.indexOf("ws") != 0) {
			throw "无效的 Scoket URL";
		}

		if (untyped !window.unwss && url.indexOf("ws://") != -1 && url.indexOf("127") == -1 && url.indexOf("192") == -1)
			url = StringTools.replace(url, "ws://", "wss://");

		_baseSocket = Wx.connectSocket({
			url: url,
			perMessageDeflate: false
		});

		_baseSocket.onClose(function(res:Dynamic):Void {
			trace(res);
			if (this.readyState == CLOSED)
				return;
			this.readyState = CLOSED;
			if (onclose != null)
				this.onclose(res);
		});

		_baseSocket.onMessage(function(res:Dynamic):Void {
			// trace(res);
			if (this.readyState == CLOSED)
				return;
			if (onmessage != null)
				this.onmessage(res);
		});

		_baseSocket.onOpen(function():Void {
			if (this.readyState == CLOSED)
				return;
			this.readyState = OPEN;
			if (onopen != null)
				this.onopen();
		});

		_baseSocket.onError(function(res:Dynamic):Void {
			trace(res);
			if (this.readyState == CLOSED)
				return;
			if (onerror != null)
				this.onerror(res);
		});

		this.readyState = CONNECTING;
	}

	public function close(code:Dynamic, reason:Dynamic):Void {
		this.readyState = CLOSING;
		_baseSocket.close({
			code: 1000,
			reason: reason
		});
	}

	public function send(data:Dynamic):Void {
		_baseSocket.send({
			data: data
		});
	}
}
