package wx;

/**
 * 微信分享接口
 */
class WxShare {
    
    /**
     * 截图分享接口
     * @param content 
     */
    public static function screenshotShare(content:String):Void
    {
        untyped __js__("window.qqCoreShare")(content);
    }
    
    /**
     * 使用本地资源分享
     * @param content 上下文
     * @param path 分享路径
     * @param call 分享成功的回调
     */
    public static function share(content:String,path:String,call:Void->Void):Void
    {
        untyped __js__("window.share")(content,path,call);
    }
}