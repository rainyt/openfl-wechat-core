
/**
 * 百度小游戏专用API
 */
@:native("swan")
extern class SWan {

    public static function requestPolymerPayment(data:Dynamic):Void;

    /**
     * 防沉迷接口为响应国家政策，对于游戏玩家做防沉迷逻辑；开发者注册此方法，当触发防沉迷条件时，调用开发者的回调方法，传递防沉迷原因以及信息，通知开发者对于游戏逻辑做防沉迷处理
     * @return AntiAddiction
     */
    public static function getAntiAddiction():AntiAddiction;

    public static function exit(data:Dynamic):Void;

}

/**
 * 防沉迷模块
 */
extern class AntiAddiction {
    
    public function onAntiAddiction(cb:Dynamic->Void):Void;

}