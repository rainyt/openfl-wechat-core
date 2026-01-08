import js.Syntax;
import window.events.Event;

/**
 * 事件管理器
 */
class EventElement {
	// 加载错误
	public var onerror:Dynamic = null;
	// 加载完成
	public var onload:Dynamic = null;
	// 进度
	public var onprogress:Dynamic = null;
	// 加载超时
	public var ontimeout:Dynamic = null;

	public var tagName:String;

	public var id:String;

	/**
	 * 事件列表
	 */
	private var events:Map<String, Array<Dynamic>> = new Map<String, Array<Dynamic>>();

	public function new() {}

	/**
	 * 侦听事件
	 * @param type 
	 * @param listener 
	 */
	public function addEventListener(type:String, listener:Dynamic) {
		var arr:Array<Dynamic> = events.get(type);
		if (arr == null) {
			arr = [];
			events.set(type, arr);
		}
		arr.push(listener);
	}

	/**
	 * 删除侦听事件
	 * @param type 
	 * @param listener 
	 */
	public function removeEventListener(type:String, listener:Dynamic) {
		var arr:Array<Dynamic> = events.get(type);
		if (arr != null) {
			arr.remove(listener);
		}
	}

	/**
	 * 回调事件
	 * @param event 
	 */
	public function dispatchEvent(event:Event):Void {
		if (event.type != null && event.type.indexOf("on") == 0)
			event.type = event.type.substr(2);
		var arr:Array<Dynamic> = events.get(event.type);
		if (arr != null) {
			for (e in arr)
				e(event);
		}
	}

	/**
	 * 统一on事件发送
	 * @param type 
	 * @param event 
	 */
	private function triggerEvent(type:String, event:Event = null):Void {
		if (event == null)
			event = new Event(type);
		event.target = event.target != null ? event.target : this;
		js.Syntax.code("
        if (typeof this[`on${type}`] === 'function') {
            this[`on${type}`].call(this, event);
        }");
		dispatchEvent(event);
	}
}
