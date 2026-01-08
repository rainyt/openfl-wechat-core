
@:native("mgc")
extern class Mgc {

    /**
     * 创建扩展广告类型
     * @param data 
     */
    public static function createExtendedAd(data:Dynamic):Dynamic;

    /**
     * 创建信息流广告
     * @param data 
     * @return Dynamic
     */
    public static function createFeedAd(data:Dynamic):Dynamic;

}