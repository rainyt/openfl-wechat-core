/**
 * 字节跳过API
 */
#if baidu
@:native("swan")
#else
@:native("tt")
#end
extern class TT {
	/**
	 * 获取一个录制全局对象
	 * @return tt.GameRecorderManager
	 */
	#if baidu
	@:native("getVideoRecorderManager")
	#end
	public static function getGameRecorderManager():tt.GameRecorderManager;

	/**
	 * 拉起视频发布器
	 * @param data 
	 */
	public static function shareVideo(data:Dynamic):Void;

	/**
	 * 创建更多游戏按钮
	 * @param data 
	 */
	public static function createMoreGamesButton(data:Dynamic):Dynamic;

	/**
	 * 展示更多游戏模态层
	 */
	public static function showMoreGamesModal(data:Dynamic):Void;

	/**
	 * 授权接口
	 * @param data 
	 */
	public static function authorize(data:Dynamic):Void;

	/**
	 * IOS白名单支付接口
	 * @return 
	 */
	public static function openAwemeCustomerService(data:Dynamic):Void;
}
