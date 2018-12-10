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

    public function onEnded(callback:Void->Void):Void;

    public function onStop(callback:Void->Void):Void;

}