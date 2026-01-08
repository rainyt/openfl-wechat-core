package window.events;

import window.events.Event;

class TouchEvent extends Event {
	public var touches:Array<Dynamic> = [];

	public var targetTouches:Array<Dynamic> = [];

	public var changedTouches:Array<Dynamic> = [];

	public function new(type:String):Void {
		super(type);
		this.target = untyped window.canvas;
		this.currentTarget = untyped window.canvas;
	}

	public function preventDefault():Void {}
}
