package qq;

/**
 * QQ平台推出的广告盒子组件
 */
extern class AppBox {

    /**
     * 载入广告
     */
    public function load():Void;

    /**
     * 进行展示广告
     */
    public function show():Void;

    /**
     * 释放广告盒子
     */
    public function destroy():Void;

    /**
     * 关闭侦听
     * @param cb 
     */
    public function onClose(cb:Dynamic):Void;

    /**
     * 取消关闭侦听
     * @param cb 
     */
    public function offClose(cb:Dynamic):Void;

}