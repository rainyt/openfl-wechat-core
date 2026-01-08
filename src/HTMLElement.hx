@:expose
class HTMLElement extends Element {

	public var clientWidth:Float;

	public var clientHeight:Float;

	public function new(type:String):Void {
		super();
		tagName = type;
	}

	/**
	 * 返回值是一个 DOMRect 对象，这个对象是由该元素的 getClientRects() 方法返回的一组矩形的集合, 即：是与该元素相关的CSS 边框集合 。
	 * @return Dynamic
	 */
	public function getBoundingClientRect():Dynamic {
		var rect:Dynamic = {
			x: 0,
			y: 0,
			top: 0,
			left: 0,
			width: Window._window.innerWidth,
			height: Window._window.innerHeight
		};
		rect.right = this.width;
		rect.bottom = this.height;
		return rect;
	}

	public function appendChild(child:Dynamic):Void {}
}
