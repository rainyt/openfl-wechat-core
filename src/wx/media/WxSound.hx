package wx.media;

@:native("InnerAudioContext")
extern class WxSound {

    public var src:String;

    public var startTime:Float;

    public var autoplay:Bool;

    public var loop:Bool;

    public var obeyMuteSwitch:Bool;

    public var volume:Float;

    public function play():Void;

    public function stop():Void;

    public function destroy():Void;

    public function onEnded(callback:Dynamic):Void;

    public function onStop(callback:Dynamic):Void;

    public function offEnded(callback:Dynamic):Void;

    public function offStop(callback:Dynamic):Void;
}