package common.media;

import wx.media.WxSound;

/**
 * 音频库功能
 */
class SoundPool {
	public static var pool:Array<WxSound> = [];

	public static function push(sound:WxSound) {
		// #if (!baidu && !bili && !qqquick)
		// if(pool.indexOf(sound) == -1)
		//     pool.push(sound);
		// #end
		if (sound != null)
			sound.destroy();
	}

	public static function get():WxSound {
		// #if (!baidu && !bili && !qqquick)
		// if(pool.length > 0)
		// {
		//     return pool.shift();
		// }
		// #end
		return Wx.createSound();
	}
}
