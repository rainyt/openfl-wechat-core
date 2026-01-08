package window.events;

/**
 * 事件流
 */
class Event {

    public var cancelBubble:Bool = false;

    public var cancelable:Bool = false;

    public var target:Dynamic = null;

    public var currentTarget:Dynamic = null;

    public var type:String;

    public var timeStamp:Int;

    public function new(type:String){
        this.type = type;
    }

}