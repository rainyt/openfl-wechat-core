import wx.FeedbackButton;
import qq.AppBox;
import wx.WxImage;
import wx.media.WxSound;
import wx.WxWebSocket;
import InterstitialAd;

#if meituan
@:native("wx")
#elseif ks
@:native("ks")
#elseif wifi
@:native("wuji")
#elseif g4399
@:native("gamebox")
#elseif bili
@:native("bl")
#elseif qqquick2
@:native("qq")
#elseif baidu
@:native("swan")
#else
@:native("wx")
#end
extern class Wx {
	/**
	 * 订阅消息
	 * @param data 
	 */
	public static function requestSubscribeMessage(data:Dynamic):Void;

	/**
	 * 仅支持：QQ小游戏
	 * 在手机桌面上添加该小程序的快捷启动图标。基础库最低版本1.7.1。
	 * ```haxe
	 * Wx.saveAppToDesktop({
	 *  success:()->{},
	 *  fail:()->{},
	 *  complete:()->{}
	 * });
	 * ```
	 * @param data 
	 */
	public static function saveAppToDesktop(data:Dynamic):Void;

	/**
	 * 订阅消息QQ专用API
	 * @param data 
	 */
	public static function subscribeAppMsg(data:Dynamic):Void;

	/**
	 * 将图片文件保存到相机
	 */
	public static function saveImageToPhotosAlbum(data:Dynamic):Void;

	/**
	 * 给指定的好友分享游戏信息，该接口只可在开放数据域下使用
	 * @param data 
	 */
	public static function shareMessageToFriend(data:Dynamic):Void;

	/**
	 * 在新页面中全屏预览图片。预览的过程中用户可以进行保存图片、发送给朋友等操作
	 * @return Dynamic
	 */
	public static function previewImage(data:Dynamic):Void;

	public static function getSystemInfoSync():Dynamic;

	public static function createCanvas():Dynamic;

	/**
	 * 梦工厂创建纹理功能
	 * @return Dynamic
	 */
	public static function ext_createCanvas():Dynamic;

	/**
	 * 创建音频对象
	 * @return WxSound
	 */
	@:native("createInnerAudioContext")
	public static function createSound():WxSound;

	/**
	 * 设置频率
	 * @param value 
	 */
	public static function setPreferredFramesPerSecond(value:Int):Void;

	public static function setClipboardData(option:Dynamic):Void;

	public static function getClipboardData(option:Dynamic):Void;

	/**
	 * 获取运行时启动参数
	 * @return Dynamic
	 */
	public static function getLaunchOptionsSync():Dynamic;

	public static function getEnterOptionsSync():Dynamic;

	/**
	 * 设置调试状态
	 * @param data 
	 * @return Dynamic
	 */
	public static function setEnableDebug(data:Dynamic):Dynamic;

	/**
	 * 展示动作列表
	 * @param data 
	 */
	public static function showActionSheet(data:Dynamic):Void;

	/**
	 * 分包加载处理
	 */
	public static function loadSubpackage(data:Dynamic):Dynamic;

	/**
	 * 加载字体，加载完成后会返回fontNamt，加载失败会返回null
	 */
	public static function loadFont(url:String):String;

	/**
	 * 网络请求API
	 * @param data 
	 */
	public static function request(data:Dynamic):Void;

	/**
	 * 创建微信图片
	 */
	public static function createImage():WxImage;

	/**
	 * 获取性能器
	 */
	public static function getPerformance():Dynamic;

	/**
	 * 触摸事件
	 * @param call 
	 */
	public static function onTouchStart(call:Dynamic):Void;

	public static function onTouchMove(call:Dynamic):Void;
	public static function onTouchEnd(call:Dynamic):Void;
	public static function onTouchCancel(call:Dynamic):Void;

	/**
	 * 文件系统管理器
	 * @return FileSystemManager
	 */
	public static function getFileSystemManager():FileSystemManager;

	/**
	 * 获取授权结果
	 * {
	 *  success:function(res){};
	 * }
	 * @param data 
	 */
	public static function getSetting(data:Dynamic):Void;

	/**
	 * 打开设置页面
	 * @param data 
	 */
	public static function openSetting(data:Dynamic):Void;

	/**
	 * 打开WebSocket连接
	 * @param data 
	 */
	public static function connectSocket(data:Dynamic):WxWebSocket;

	/**
	 * 登录，获取code
	 * @param data 
	 */
	public static function login(data:Dynamic):Void;

	/**
	 * 监听音频中断结束事件。在收到 onAudioInterruptionBegin 事件之后，小程序内所有音频会暂停，收到此事件之后才可再次播放成功参数
	 * @param call 
	 */
	public static function onAudioInterruptionEnd(call:Dynamic):Void;

	/**
	 * 监听音频因为受到系统占用而被中断开始事件。以下场景会触发此事件：闹钟、电话、FaceTime 通话、微信语音聊天、微信视频聊天。此事件触发后，小程序内所有音频会暂停。
	 * @param call 
	 */
	public static function onAudioInterruptionBegin(call:Dynamic):Void;

	/**
	 * 获取系统配置
	 * @param data 
	 */
	public static function getSystemInfo(data:Dynamic):Void;

	/**
	 * 创建用户授权按钮
	 * @param data 
	 */
	public static function createUserInfoButton(data:Dynamic):UserInfoButton;

	/**
	 * 创建游戏圈按钮
	 * @param data 
	 * @return UserInfoButton
	 */
	public static function createGameClubButton(data:Dynamic):GameClubButton;

	/**
	 * 创建返回意见的按钮
	 * @param data 
	 * @return FeedbackButton
	 */
	#if tt
	@:native("createContactButton")
	#end
	public static function createFeedbackButton(data:Dynamic):FeedbackButton;

	public static function getUserInfo(data:Dynamic):Dynamic;

	/**
	 * 展示APP分享入口
	 * @param data 
	 */
	public static function shareAppMessage(data:Dynamic):Void;

	/**
	 * 跳转APP
	 * @param data 
	 */
	public static function navigateToMiniProgram(data:Dynamic):Void;

	/**
	 * 环境变量
	 */
	public static var env:wx.Env;

	/**
	 * 下载资源到本地
	 * @param data 
	 */
	public static function downloadFile(data:Dynamic):Void;

	/**
	 * 获取位置
	 * @param data 
	 */
	public static function getLocation(data:Dynamic):Void;

	/**
	 * 本地储存
	 * @return Dynamic
	 */
	public static function getStorageInfoSync():Dynamic;

	public static function getStorageSync(key:String):Dynamic;

	public static function setStorageSync(key:String, value:Dynamic):Dynamic;

	public static function setStorage(data:Dynamic):Void;

	public static function removeStorageSync(key:String):Void;

	public static function clearStorageSync():Void;

	/**
	 * 侦听窗口的尺寸变化
	 * @param cb 
	 */
	public static function onWindowResize(cb:WindowEvent->Void):Void;

	/**
	 * 活动回到前台
	 * @param cb 
	 */
	public static function onShow(cb:Dynamic):Void;

	/**
	 * 活动回到后台
	 * @param cb 
	 */
	public static function onHide(cb:Dynamic):Void;

	/**
	 * 启动重力感应
	 * @param data 
	 */
	public static function startAccelerometer(data:Dynamic):Void;

	/**
	 * 设置当前小程序是否为常亮
	 * @param data 
	 */
	public static function setKeepScreenOn(data:Dynamic):Void;

	/**
	 * 关闭重力感应
	 * @param data 
	 */
	public static function stopAccelerometer(data:Dynamic = null):Void;

	/**
	 * 拉起权限
	 * @param data 
	 */
	public static function authorize(data:Dynamic):Void;

	/**
	 * 侦听重力数据
	 * @param cb 
	 */
	public static function onAccelerometerChange(cb:Dynamic->Void):Void;

	/**
	 * 内存发生饱满状态，进行警告
	 * @param cb 
	 */
	public static function onMemoryWarning(cb:Void->Void):Void;

	/**
	 * 加快触发 JavaScriptCore 垃圾回收（Garbage Collection）。GC 时机是由 JavaScriptCore 来控制的，并不能保证调用后马上触发 GC。
	 */
	public static function triggerGC():Void;

	/**
	 * 发起米大师支付
	 * @param data 
	 */
	#if tt
	// 头条的API需要使用这个
	@:native("requestGamePayment")
	#end
	public static function requestMidasPayment(data:Dynamic):Void;

	/**
	 * 创建视频广告
	 * @param data 
	 */
	public static function createRewardedVideoAd(data:Dynamic):RewardedVideoAd;

	/**
	 * 创建 banner 广告组件。请通过 wx.getSystemInfoSync() 返回对象的 SDKVersion 判断基础库版本号 >= 2.0.4 后再使用该 API。每次调用该方法创建 banner 广告都会返回一个全新的实例。
	 * @param data 
	 */
	public static function createBannerAd(data:Dynamic):BannerAd;

	/**
	 * 创建原生模板广告组件。请通过 wx.getSystemInfoSync() 返回对象的 SDKVersion 判断基础库版本号 >= 2.11.1 后再使用该 API。每次调用该方法创建原生模板广告都会返回一个全新的实例。
	 * @param data 
	 * @return BannerAd
	 */
	public static function createCustomAd(data:Dynamic):BannerAd;

	/**
	 * 从本地相册选择图片或使用相机拍照
	 * @param data 
	 */
	public static function chooseImage(data:Dynamic):Void;

	/**
	 * 创建插屏广告
	 * @param data 
	 * @return InterstitialAd
	 */
	public static function createInterstitialAd(data:Dynamic):InterstitialAd;

	/**
	 * 开放数据域消息接收器
	 * @param data 
	 */
	public static function onMessage(data:Dynamic):Void;

	/**
	 * 拉取当前用户所有同玩好友的托管数据。该接口只可在开放数据域下使用
	 * @param data 
	 */
	public static function getFriendCloudStorage(data:Dynamic):Void;

	public static function getOpenDataContext():Dynamic;

	public static function getSharedCanvas():Dynamic;

	/**
	 * 上传用户数据到托管服务器
	 * @param data 
	 */
	public static function setUserCloudStorage(data:Dynamic):Void;

	/**
	 * 展示输入键盘
	 * @param data 
	 */
	public static function showKeyboard(data:Dynamic):Void;

	/**
	 * 侦听键盘输入
	 * @param data 
	 */
	public static function onKeyboardInput(data:Dynamic):Void;

	/**
	 * 滚轮事件
	 * @param {}->Void 
	 */
	public static function onWheel(cb:WheelEvent->Void):Void;

	/**
	 * 取消滚轮事件
	 * @param cb 
	 */
	public static function offWheel(cb:WheelEvent->Void):Void;

	/**
	 * 侦听键盘收起
	 * @param call 
	 */
	public static function onKeyboardComplete(call:Dynamic):Void;

	public static function onKeyboardConfirm(call:Dynamic):Void;

	/**
	 * 退出小程序
	 * @param (data 
	 */
	public static function exitMiniProgram(?data:Dynamic):Void;

	/**
	 * 监听键盘按键按下事件，仅适用于 PC 平台
	 * @param listener 键盘按键按下事件的监听函数
	 */
	public static function onKeyDown(listener:wx.KeyCode->Void):Void;

	/**
	 * 监听键盘按键弹起事件，仅适用于 PC 平台
	 * @param listener 键盘按键弹起事件的监听函数
	 */
	public static function onKeyUp(listener:wx.KeyCode->Void):Void;

	public static function hideKeyboard(call:Dynamic = null):Void;

	/**
	 * 展示toast处理
	 * @param call 
	 */
	public static function showToast(call:Dynamic):Void;

	/**
	 * 显示分享菜单
	 * @param data 
	 */
	public static function showShareMenu(data:Dynamic):Void;

	public static function onShareAppMessage(data:Dynamic):Void;

	/**
	 * 上传文件
	 * @param data 
	 */
	public static function uploadFile(data:Dynamic):Void;

	/**
	 * 创建广告盒子API，该API仅可以在QQ平台使用
	 * @param data 
	 */
	public static function createAppBox(data:Dynamic):AppBox;

	/**
	 * 获取更新管理器
	 * @return UpdateManager
	 */
	public static function getUpdateManager():wx.UpdateManager;

	/**
	 * 展示模态窗口
	 * @param data 
	 */
	public static function showModal(data:Dynamic):Void;

	/**
	 * 调起小游戏系统订阅消息界面，返回用户订阅消息的操作结果。当用户勾选了订阅面板中的“总是保持以上选择，不再询问”时，模板消息会被添加到用户的小游戏设置页，通过 wx.getSetting 接口可获取用户对相关模板消息的订阅状态。
	 * @param data 
	 */
	public static function requestSubscribeSystemMessage(data:Dynamic):Void;

	/**
	 * 进入客服会话。要求在用户发生过至少一次 touch 事件后才能调用。后台接入方式与小程序一致
	 * @param data 
	**/
	public static function openCustomerServiceConversation(data:{
		?type:Int,
		?sessionFrom:String,
		?showMessageCard:Bool,
		?sendMessageTitle:String,
		?sendMessagePath:String,
		?sendMessageImg:String,
		?success:Dynamic->Void,
		?fail:Dynamic->Void,
		?complete:Dynamic->Void
	}):Void;

	/**
	 * 获取游戏圈数据
	 */
	public static function getGameClubData(data:{
		dataTypeList:Array<{
			type:Int
		}>,
		?success:GameClubData->Void,
		?fail:Dynamic->Void,
		?complete:Dynamic->Void
	}):Void;

	/**
	 * 获取设备性能得分和机型档位数据
	 * @param data 
	 */
	public static function getDeviceBenchmarkInfo(data:Dynamic):Void;
}

typedef WindowEvent = {
	windowWidth:Float,
	windowHeight:Float
}

typedef WheelEvent = {
	deltaX:Float,
	deltaY:Float,
	deltaZ:Float,
	x:Float,
	y:Float,
	timeStamp:Float
}

/**
 * 游戏圈数据
 */
typedef GameClubData = {
	rrMsg:String,
	data:{
		errCode:Int
	},
	signature:String,
	encryptedData:String,
	iv:String,
	cloudID:String
}
