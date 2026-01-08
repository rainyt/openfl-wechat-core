
/**
 * 用户信息按钮
 */
extern class UserInfoButton {

    /**
     * 展示按钮，默认是隐藏状态
     */
    public function show():Void;

    /**
     * 隐藏状态
     */
    public function hide():Void;

    /**
     * 丢弃该按钮
     */
    public function destroy():Void;

    public var style:Dynamic;

    /**
     * 侦听回调
     * @param callback 
     */
    public function onTap(callback:Dynamic->Void):Void;

    /**
     * 取消回调
     * @param callback 
     */
    public function offTap(callback:Dynamic->Void):Void;

}