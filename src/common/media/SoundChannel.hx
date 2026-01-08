package common.media;

import openfl.media.SoundTransform;
import wx.media.WxSound;
import openfl.events.EventDispatcher;
import openfl.events.Event;

class SoundChannel extends EventDispatcher {
	private var _sound:WxSound;

	private var _isStop:Bool = false;

	private var __soundTransform:SoundTransform = new SoundTransform();

	/**
		The SoundTransform object assigned to the sound channel. A SoundTransform
		object includes properties for setting volume, panning, left speaker
		assignment, and right speaker assignment.
	**/
	public var soundTransform(get, set):SoundTransform;

	private function set_soundTransform(value:SoundTransform):SoundTransform {
		if (_sound != null) {
			_sound.volume = value.volume;
		}
		__soundTransform = value;
		return value;
	}

	private function get_soundTransform():SoundTransform {
		return __soundTransform;
	}

	public function new(sound:WxSound) {
		super();
		_sound = sound;
		_sound.autoplay = true;
		_sound.onEnded(onSoundEnd);
		_sound.onStop(onSoundEnd);
		_sound.play();
	}

	public function offEvents():Void {
		if (_sound == null)
			return;
		_sound.offEnded(onSoundEnd);
		_sound.offStop(onSoundEnd);
	}

	private function onSoundEnd(res:Dynamic):Void {
		if (_isStop || _sound == null)
			return;
		offEvents();
		_isStop = true;
		if (_sound.loop) {
			_sound.play();
			dispatchEvent(new Event(Event.SOUND_COMPLETE));
			return;
		} else {
			SoundPool.push(_sound);
		}
		if (_sound != null)
			dispatchEvent(new Event(Event.SOUND_COMPLETE));
		_sound = null;
	}

	public function stop():Void {
		if (_sound != null) {
			offEvents();
			_isStop = true;
			_sound.src = "";
			_sound.autoplay = false;
			_sound.loop = false;
			#if qqquick
			_sound.stop();
			_sound.destroy();
			#elseif (qihoo)
			_sound.destroy();
			#else
			try {
				_sound.stop();
			} catch (e:Dynamic) {}
			#if (baidu || mgc || bili || g4399)
			#else
			if (!_sound.loop) {
				SoundPool.push(_sound);
			} else {
				_sound.destroy();
			}
			#end
			#end
			_sound = null;
		}
	}
}
