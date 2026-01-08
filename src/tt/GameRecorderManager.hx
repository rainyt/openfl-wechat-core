package tt;

/**
 * 接口仅适用于字节跳动
 */
extern class GameRecorderManager {

    /**
     * 开始录制视频
     * @param data {duration:录制时长}
     */
    public function start(data:Dynamic):Void;

    /**
     * 停止录制
     */
    public function stop():Void;

    /**
     * 录制成功后，会返回一个视频路径
     * @param call 
     */
    public function onStop(call:Dynamic->Void):Void;

    /**
     * 录制失败
     * @param call 
     */
    public function onError(call:Dynamic->Void):Void;

}