package window.events;

/**
 * 键盘事件
 */
class KeyboradEvent extends Event {
	public var code:String;

	public var key:String;

	public var keyCode:Int;

	public function new(type:String):Void {
		super(type);
		this.target = untyped window.canvas;
		this.currentTarget = untyped window.canvas;
	}
}
