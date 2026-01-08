package common.media;

import haxe.crypto.Base64;
import openfl.utils.ByteArray;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.IOErrorEvent;
import common.media.SoundChannel;
import wx.media.WxSound;
import common.media.SoundPool;

class Sound extends EventDispatcher {
	public static var tmepIndex:Int = 0;

	public var url:URLRequest;

	public var localPath:String;

	public function load(url:URLRequest):Void {
		this.url = url;
		HTMLUtils.ofPathNoSync(url.url, function(path) {
			if (!HTMLUtils.cacheAssets(path, "binary", function(data:Dynamic):Void {
				this.localPath = data;
				dispatchEvent(new Event(Event.COMPLETE));
			}, function():Void {
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}, true)) {
				// 只能使用网络地址播放
				this.localPath = url.url;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		});
	}

	public function play(startTime:Int = 0, loop:Int = 1, isLoop:Bool = false):SoundChannel {
		var sound:WxSound = SoundPool.get();
		sound.src = localPath;
		sound.loop = loop >= 9999 ? true : isLoop;
		var channel:SoundChannel = new SoundChannel(sound);
		return channel;
	}

	public function close():Void {}

	public function loadCompressedDataFromByteArray(bytes:ByteArray, bytesLength:Int):Void {
		localPath = Wx.env.USER_DATA_PATH + "/" + "temp_sound_" + tmepIndex;
		var base64 = Base64.encode(bytes);
		Wx.getFileSystemManager().writeFile({
			filePath: localPath,
			data: base64,
			encoding: "base64",
			success: function():Void {
				dispatchEvent(new Event(Event.COMPLETE));
			},
			fail: function(ret):Void {
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		});
		tmepIndex++;
	}
}
