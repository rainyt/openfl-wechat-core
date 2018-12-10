package common.media;

import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoaderDataFormat;
import common.media.SoundChannel;
import haxe.crypto.Md5;
import wx.media.WxSound;

class Sound extends EventDispatcher implements zygame.media.base.Sound{

    public var url:URLRequest;

    public var localPath:String;

    public function load(url:URLRequest):Void
    {
        this.url = url;

        localPath = untyped __js__("window.changLocaName")(url.url);
        Wx.getFileSystemManager().access({
            path:localPath,
            success:function():Void{
                // trace("is access file:"+localPath);
                dispatchEvent(new Event(Event.COMPLETE));
            },
            fail:function():Void{
                var load:URLLoader = new URLLoader();
                load.dataFormat = URLLoaderDataFormat.BINARY;
                load.load(url);
                //加载二进制
                load.addEventListener(Event.COMPLETE,function(_):Void{
                    // trace("加载完成",this.url," -> ",localPath);
                    dispatchEvent(new Event(Event.COMPLETE));
                });
                load.addEventListener(IOErrorEvent.IO_ERROR,function(_):Void{
                    // trace("加载失败");
                    dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                });
            }
        });
    }

    public function play(startTime:Int = 0,loop:Int = 1,isLoop:Bool = false):SoundChannel
    {
        // trace("play sound :"+localPath);
        var sound:WxSound = Wx.createSound();
        sound.src = localPath;
        sound.loop = isLoop;
        var channel:SoundChannel = new SoundChannel(sound); 
        return channel;
    }

    public function close():Void
    {

    }

}