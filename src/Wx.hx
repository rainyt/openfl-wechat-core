import wx.media.WxSound;

@:native("wx")
extern class Wx {

    @:native("createInnerAudioContext")
    public static function createSound():WxSound;

    public static function getFileSystemManager():FileSystemManager;

}