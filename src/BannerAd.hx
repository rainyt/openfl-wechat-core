
/**
 * Banner广告组件
 */
 extern class BannerAd
 {

    public  var style:Dynamic;
    /**
     * 销毁banner广告
     */
     public function destroy():Void;

    /**
     * 隐藏banner广告
     */
     public function hide():Void;

     /**
     * 取消监听banner广告错误事件
     */
     public function offError(callback:Dynamic->Void):Void;

    /**
     * 取消监听banner广告加载事件
     */
     public function offLoad(callback:Dynamic->Void):Void;

    /**
     * 取消监听banner广告尺寸变化事件
     */
     public function offResize(callback:Dynamic->Void):Void;

    /**
     * 监听banner广告错误事件
     */
     public function onError(callback:Dynamic->Void):Void;


    /**
     * 监听banner广告加载事件
     */
     public function onLoad(callback:Dynamic->Void):Void;

     /**
     * 监听banner广告尺寸变化事件
     */
     public function onResize(callback:Dynamic->Void):Void;

     /**
     * 显示 banner 广告。
     */
     public function show():Void;

    public var sizeWidth:Float;

    public var sizeHeight:Float;

 }
