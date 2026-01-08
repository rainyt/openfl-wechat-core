package window.events;

import window.events.Event;

/**
 * 重力事件
 */
class DeviceMotionEvent extends Event
{

    /**
     * 加速数据
     */
    public var accelerationIncludingGravity:Dynamic;

    public var rotationRate:Dynamic;

    public var interval:Float;

    public function new(){
        super("devicemotion");
    }

}