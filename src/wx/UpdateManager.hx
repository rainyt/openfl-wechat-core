package wx;

extern class UpdateManager {

    /**
     * 强制更新
     */
    public function applyUpdate():Void;

    /**
     * 检查是否存在更新，冷启动时会自动检查更新
     */
    public function onCheckForUpdate(cb:Dynamic->Void):Void;

    /**
     * 检查更新下载程序包失败
     * @param cb 
     */
    public function onUpdateFailed(cb:Dynamic->Void):Void;

    /**
     * 检查更新下载程序包成功
     * @param cb 
     */
    public function onUpdateReady(cb:Dynamic->Void):Void;

}