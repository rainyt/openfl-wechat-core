import js.lib.Promise;

/**
 * 视频广告组件
 */
extern class RewardedVideoAd {


    /**
     * 隐藏激励视频广告
     */
    public function load():Promise<Dynamic>;

    /**
     * 取消监听用户点击 关闭广告 按钮的事件
     * @param callback -用户点击关闭广告按钮的事件的回调函数
     */
    public function offClose(callback:Dynamic->Void):Void;

    /**
     * 取消监听激励视频错误事件
     * @param callback -激励视频错误事件的回调函数
     */
    public function offError(callback:Dynamic->Void):Void;

    /**
     * 取消监听激励视频广告加载事件
     * @param callback -激励视频广告加载事件的回调函数
     */
    public function offLoad(callback:Dynamic->Void):Void;

    /**
     * 监听用户点击 关闭广告 按钮的事件
     * @param callback -用户点击 关闭广告 按钮的事件的回调函数
     */
    public function onClose(callback:Dynamic->Void):Void;

    /**
     * 监听激励视频错误事件
     * @param callback -激励视频错误事件的回调函数
     */
    public function onError(callback:Dynamic->Void):Void;

    /**
     * 监听激励视频广告加载事件
     * @param callback -激励视频广告加载事件的回调函数
     */
    public function onLoad(callback:Dynamic->Void):Void;

    /**
     * 显示激励视频广告。激励视频广告将从屏幕下方推入
     * @param callback -激励视频广告加载事件的回调函数
     */
    public function show():Promise<Dynamic>;

    /**
     * 释放当前视频广告
     */
    public function destroy():Void;

    public var isReady:Bool;

}