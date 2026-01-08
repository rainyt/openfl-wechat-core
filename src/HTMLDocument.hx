@:expose
class HTMLDocument extends HTMLElement {
	// 网页信息
	public var location:Location;

	public var textcanvas:Canvas;

	public var readyState:String = "complete";  

	public function new(type:String):Void {
		super(type);
	}

	public function exitFullscreen():Void {}

	public function getElementById(id:String):Dynamic {
		if (id == "GameCanvas" || id == "webgl") {
			return untyped window.canvas;
		} else if (untyped window.canvas != null && id == untyped window.canvas.id) {
			return untyped window.canvas;
		}
		return null;
	}

	public function createElementNS(type:String):Dynamic {
		return null;
	}

	public function createTextNode(chars:String):Dynamic {
		return null;
	}

	public function createElement(type:String):HTMLElement {
		type = type.toLowerCase();
		if (type == "textcanvas") {
			if (textcanvas == null)
				textcanvas = new Canvas();
			textcanvas.getContext("2d").clearRect(0, 0, textcanvas.width, textcanvas.height);
			return textcanvas;
		} else if (type == "canvas") {
			return new Canvas();
		} else if (type == "audio") {} else if (type == "img") {} else if (type == "video") {}
		return new HTMLElement(type);
	}
}
