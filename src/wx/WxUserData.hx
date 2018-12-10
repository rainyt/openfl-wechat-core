package wx;

import WxCore;

/**
 * 用户数据获取接口
 */
class WxUserData {

    private static var _nickName:String = null;

    /**
     * 获取用户昵称(当获取失败的时候，将获取史小坑默认名)
     * @return String
     */
    public static function getNickName():String
    {
        return _nickName != null?_nickName:"史小坑";
    }

    /**
     * 初始化数据
     */
    public static function init():Void
    {
        untyped __js__("window.getUserInfo")();
    }

    // /**
    //  * 获取OpenID
    //  * @return Int
    //  */
    // public static function getOpenID():String
    // {
    //     return untyped __js__("GameStatusInfo.openId");
    // }

    /**
     * 获取系统平台
     */
    public static function getPlatform():String
    {
        return untyped __js__("window.curPlatform");
    }
    
    /**
      * 开启重力感应
    */
    public static function startAccelerometer(callback:Int->Int->Int->Void):Void
    {
        untyped __js__("window.startAccelerometer")(callback);
    }

    /**
      * 关闭重力感应
    */
    public static function stopAccelerometer():Void
    {
        return untyped __js__("window.stopAccelerometer")();
    }

    /**
      * 开启设备方向监听
    */
    public static function startDeviceMotionListening(callback:Int->Int->Int->Void):Void
    {
        untyped __js__("window.startDeviceMotionListening")(callback);
    }

    /**
     * 关闭设备方向监听
    */
    public static function stopDeviceMotionListening():Void
    {
        return untyped __js__("window.stopDeviceMotionListening")();
    }

    /**
    * 跳转至其他微信小游戏
    */
    public static function navigateToMiniProgram():Void
    {
       return untyped __js__("window.navigateToMiniProgram")();
    }
}