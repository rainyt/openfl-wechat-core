package common.media;

import wx.media.WxSound;
import openfl.events.EventDispatcher;
import openfl.events.Event;

class SoundChannel extends EventDispatcher implements zygame.media.base.SoundChannel {

    private var _sound:WxSound;

    private var _isStop:Bool = false;

    public function new(sound:WxSound)
    {
        super();
        _sound = sound;
        _sound.autoplay = true;
        _sound.onEnded(function():Void{
            if(_isStop)
                return;
            _isStop = true;
            _sound.destroy();
            dispatchEvent(new Event(Event.SOUND_COMPLETE));
        });
        _sound.onStop(function():Void{
            if(_isStop)
                return;
            _isStop = true;
            _sound.destroy();
            dispatchEvent(new Event(Event.SOUND_COMPLETE));
        });
        _sound.play();
    }

    public function stop():Void
    {
        if(_sound != null)
            _sound.stop();
    }

}