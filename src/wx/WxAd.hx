package wx;

/**
 * 广告
 */
class WxAd {
    // 加载广告
    public static function loadAd():Void
    {
        untyped __js__("window.loadAd")();
    }
    
    // banner 
    public static function showBannerAd():Void
    {
        untyped __js__("window.showBannerAd")();
    }
    // closebanner 
    public static function closeBannerAd():Void
    {
        untyped __js__("window.closeBannerAd")();
    }

    // 视频广告
     public static function showVideoAd(call:Bool->Void):Void
    {
        untyped __js__("window.showVideoAd")(function(bool:Bool):Void{
            call(bool);
        });
    }
    // 返回个布尔判断视频key是否存在
    public static function videoKeyIsOrNo():Bool
    {
       return untyped __js__("window.videoKeyIsOrNo")();
    }
     

}
