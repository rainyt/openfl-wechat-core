import haxe.Exception;
import window.events.Event;
import window.events.KeyboradEvent;
import js.html.Console;
import Image;
import HTMLCanvasElement;
import HTMLAudioElement;
import Canvas;
import HTMLDocument;
import XMLHttpRequest;
import CanvasRenderingContext2D;
import WebSocket;
import window.events.TouchEvent;
import window.events.DeviceMotionEvent;
#if vscode
import open.WxSharedCanvasImage;
#end

@:expose
class Window extends HTMLElement {
	/**
	 * 主屏Canvas
	 */
	public static var canvas:HTMLCanvasElement = new Canvas();

	public static var _window:Window;

	public static var platform:String;

	public static var systemInfo:Dynamic;

	public static function main() {
		canvas.id = "mainCanvas";
		// 获取微信的平台处理
		systemInfo = Wx.getSystemInfoSync();
		platform = systemInfo.platform;
		#if !unwindow
		_window = new Window();
		// 开发者工具时处理
		try {
			if (#if (g4399 || mgc) true #else (untyped GameGlobal.isIOSHighPerformanceMode || platform == 'devtools' || platform == "windows"
				|| platform == "mac") #end) {
				js.Syntax.code("
                for(const key in Window._window)
                {
                    const descriptor = Object.getOwnPropertyDescriptor(global, key)
                    if (!descriptor || descriptor.configurable === true) {
                        if(key != 'document' && key != 'location'){
                            Object.defineProperty(window, key, {
                                value: Window._window[key]
                            })
                        }
                    }
                }
				if(window.document == null){
					window.document = {};
				}
                for (const key in  Window._window.document) {
                    const descriptor = Object.getOwnPropertyDescriptor(window.document, key)
                    if (!descriptor || descriptor.configurable === true) {
                        Object.defineProperty(window.document, key, {
                            value:  Window._window.document[key]
                        })
                    }
                }
				if(window.location == null){
					Object.defineProperty(window, 'location', {
						value: Window._window.location
					})
				}
                window.parent = window;
            ");
			} else {
				#if bili
				try {
					// B站逻辑
					// global.document = this.document;
					js.Syntax.code("for (const key in Window._window) {
                global[key] = Window._window[key]
            }
            global.window = global;
            global.top = global.parent = global");
				} catch (e:Dynamic) {
					untyped window.isWebView = true;
				}
				#elseif qqquick
				js.Syntax.code("for (const key in Window._window) {
                global[key] = Window._window[key]
            }
            for (const key2 in Window._window) {
                window[key2] = Window._window[key2]
            }
            global.window = global;
            global.top = global.parent = global");
				#else
				js.Syntax.code("for (const key in Window._window) {
                global[key] = Window._window[key]
            }
            global.window = global;
            global.top = global.parent = global");
				#end

				// Wx.request 调试
				// untyped wx._requestCounts = 0;
				// untyped wx._request = wx.request;
				// untyped wx.request = function(data) {
				// 	untyped wx._requestCounts++;
				// 	// trace("request:", untyped wx._requestCounts, data);
				// 	data.complete = function() {
				// 		untyped wx._requestCounts--;
				// 	};
				// 	// trace("untyped wx._requestCounts=", untyped wx._requestCounts);
				// 	wx._request(data);
				// }
			}
		} catch (e:Exception) {
			trace("Window.Exception", e.message, e.stack.toString());
		}

		// #if (!ks)
		if (untyped window.performance == null #if qqquick || platform != "devtools" && platform != "ios" #end) {
			_window.performance = new Performance2();
			untyped window.performance = _window.performance;
		}
		// #end

		untyped window.platform = Window.platform;
		untyped window.systemInfo = Window.systemInfo;
		untyped window.showQuery = {};

		// 触摸事件实现
		listenerTouchEvent();

		#if weixin
		// 键盘事件实现
		listenerKeyEvent();
		#end
		#end
	}

	public static function listenerKeyEvent():Void {
		Wx.onKeyDown(onKeyDown);
		Wx.onKeyUp(onKeyUp);
	}

	public static function onKeyDown(data:wx.KeyCode):Void {
		var event:KeyboradEvent = new KeyboradEvent("keydown");
		event.key = data.key;
		event.code = data.code;
		event.keyCode = StringTools.fastCodeAt(data.key, 0);
		Window._window.dispatchEvent(event);
	}

	public static function onKeyUp(data:wx.KeyCode):Void {
		var event:KeyboradEvent = new KeyboradEvent("keyup");
		event.key = data.key;
		event.code = data.code;
		event.keyCode = StringTools.fastCodeAt(data.key, 0);
		Window._window.dispatchEvent(event);
	}

	public function matchMedia():Dynamic {
		return {
			addListener: function(data) {}
		};
	}

	/**
	 * 侦听触摸事件
	 */
	public static function listenerTouchEvent():Void {
		Wx.onTouchStart(eventHandlerFactory("touchstart"));
		Wx.onTouchMove(eventHandlerFactory("touchmove"));
		Wx.onTouchEnd(eventHandlerFactory("touchend"));
		Wx.onTouchCancel(eventHandlerFactory("touchcancel"));
	}

	private static var lastStartTouchData:Dynamic = null;

	private static var startTouch:Array<Dynamic> = [];

	private static function eventHandlerFactory(type:String):Dynamic->Void {
		return function(data:Dynamic):Void {
			if (type == "touchstart") {
				startTouch.push(data);
			} else if (type == "touchend") {
				if (startTouch.length > 0)
					startTouch.shift();
			}
			var event:TouchEvent = new TouchEvent(type);
			// event.changedTouches = data.changedTouches;
			event.changedTouches = data.changedTouches;
			event.touches = data.touches;
			canvas.dispatchEvent(event);
		};
	}

	/**
	 * 当发生onHide的时候，需要清空所有touchstart事件
	 */
	private static function clearTouchStart():Void {
		for (data in startTouch) {
			var event:TouchEvent = new TouchEvent("touchend");
			event.changedTouches = data.changedTouches;
			event.touches = data.touches;
			canvas.dispatchEvent(event);
		}
	}

	// ----  WINDOW ---- 方法实现
	// document入口
	public var document:HTMLDocument = new HTMLDocument("DOM");

	// 设备分辨率比
	public var devicePixelRatio:Float = 1;

	// 网页信息
	public var location:Location;

	//
	public var navigator:Navigator;

	public var innerWidth:Float;

	public var innerHeight:Float;

	// 数据储存
	public var localStorage:LocalStorage;

	// #if !ks
	public var performance:Dynamic;

	// #end
	public var supported:Bool = true;

	public function new() {
		super("WINDOW");
		#if mgc
		innerWidth = untyped window.__innerWidth;
		innerHeight = untyped window.__innerHeight;
		#else
		innerWidth = systemInfo.screenWidth;
		innerHeight = systemInfo.screenHeight;
		#end
		#if (!qihoo)
		var scale1 = innerWidth > innerHeight ? 1980 / innerHeight : 1080 / innerWidth;
		var scale2 = innerHeight > innerWidth ? 1980 / innerHeight : 1080 / innerHeight;
		devicePixelRatio = Math.max(scale1, scale2);

		var settingDevicePixelRatio:Dynamic = Wx.getStorageSync("wechat_devicePixelRatio");
		if (settingDevicePixelRatio != "" || settingDevicePixelRatio != null) {
			var newdevicePixelRatio = Std.parseInt(Std.string(settingDevicePixelRatio));
			if (newdevicePixelRatio >= 1 && newdevicePixelRatio < devicePixelRatio) {
				devicePixelRatio = newdevicePixelRatio;
			}
		}

		if (platform == "windows") {
			devicePixelRatio = 2;
		} else {
			if (systemInfo != null && systemInfo.pixelRatio != null)
				devicePixelRatio = systemInfo.pixelRatio;
			else if (devicePixelRatio > 2)
				devicePixelRatio = 2;
		}
		// 由于DPI自动感知的原因，如果这个尺寸太大，会导致IOS内存不足
		// if (systemInfo.platform == "ios" || systemInfo.platform == "android") {
		// if (devicePixelRatio > 2) {
		// devicePixelRatio = 2;
		// }
		// }
		#end
		Console.log("分辨率比：", devicePixelRatio, systemInfo.platform);
		untyped window.devicePixelRatio = devicePixelRatio;
		location = new Location();
		navigator = new Navigator();
		localStorage = new LocalStorage();
		document.location = location;

		#if !OPENDATA_ENGINE
		// 设置FPS为60
		#if !meituan
		Wx.setPreferredFramesPerSecond(60);
		#end

		// 快手暂不支持重力感应
		if (Wx.onAccelerometerChange != null)
			Wx.onAccelerometerChange(onAccelerometerChange);

		// 活动恢复侦听
		if (Wx.onAudioInterruptionBegin != null)
			Wx.onAudioInterruptionBegin(onHide);
		Wx.onHide(onHide);
		if (Wx.onAudioInterruptionEnd != null)
			Wx.onAudioInterruptionEnd(onShow);
		Wx.onShow(onShow);

		#if qqquick
		Wx.showShareMenu({
			showShareItems: ['qq', 'qzone']
		});
		Wx.onShareAppMessage(function() {
			// 用户点击了“转发”按钮
			return {
				title: '游戏还能这样玩？试试你的脑洞够不够！'
			}
		});
		#end

		// 常亮设置
		if (Wx.setKeepScreenOn != null)
			Wx.setKeepScreenOn({
				keepScreenOn: true
			});

		// 内存警告，警告的时候，将进行尝试内存释放
		try {
			#if !meituan
			Wx.onMemoryWarning(function():Void {
				if (Wx.triggerGC != null)
					Wx.triggerGC();
			});
			#end
		} catch (e:Dynamic) {
			untyped console.log("wx.onMemoryWarning is not support!");
		}
		#end

		untyped window.shareApp = share;

		// 暂不支持
		// untyped setInterval(function() {
		// 	Wx.getSystemInfo({
		// 		success: (result) -> {
		// 			if (result == null)
		// 				return;
		// 			if (this.innerWidth != result.screenWidth || this.innerHeight != result.screenHeight) {
		// 				this.innerWidth = result.screenWidth;
		// 				this.innerHeight = result.screenHeight;
		// 				var cw = this.innerWidth;
		// 				var ch = this.innerHeight;
		// 				untyped window.canvas.width = cw * this.devicePixelRatio;
		// 				untyped window.canvas.height = ch * this.devicePixelRatio;
		// 				this.triggerEvent("resize");
		// 			}
		// 		},
		// 	});
		// }, 250);
	}

	private static var shareCallBack:Dynamic;

	/**
	 * 分享接口实现
	 * @param shareData 分享的内容
	 * @param icon 分享的图片
	 * @param callback 分享回调，微信拿不到真实的回调地址，因此会以返回的时间进行返回 （暂未实现，无回调）
	 * @param extinfo 扩展参数，需要为key1=value1&key2=value2的值
	 * @param isWebPath 是否为WEB路径，默认为true
	 */
	public static function share(shareData:String, icon:String, callback:Dynamic, extinfo:Dynamic, isWebPath:Bool = true, failCallBack:Dynamic = null) {
		#if g4399
		untyped gamebox.shareMessageToFriend({
			type: 0,
			success: function() {
				if (callback != null)
					callback();
			},
			fail: function() {
				if (failCallBack != null)
					failCallBack();
			}
		});
		return;
		#end

		if (icon.indexOf("http") == -1 && isWebPath) {
			icon = untyped window.webPath + "/" + icon;
		}
		#if (!bili)
		shareCallBack = callback;
		#end
		var param = "";
		if (!Std.is(extinfo, String)) {
			var keys:Array<String> = Reflect.fields(extinfo);
			for (key in keys) {
				param += key + "=" + Reflect.getProperty(extinfo, key) + "&";
			}
			param += "end=1";
		} else
			param = extinfo;
		trace("share:", param);
		Wx.shareAppMessage({
			title: shareData,
			imageUrl: icon,
			query: param,
			#if (bili)
			success: callback, fail: failCallBack == null ? null : function() {
				failCallBack();
			}
			#end
		});
		untyped window.addEventListener("focus", onShareFocus);
	};

	private static function onShareFocus(_):Void {
		untyped window.removeEventListener("focus", onShareFocus);
		if (shareCallBack != null)
			shareCallBack();
	}

	/**
	 * 打开重力感应支持
	 */
	public function openAccelerometerChange():Void {
		Wx.startAccelerometer({
			success: function():Void {},
			fail: function():Void {}
		});
	}

	/**
	 * 关闭重力感应支持
	 */
	public function closeAccelerometerChange():Void {
		Wx.stopAccelerometer({
			success: function():Void {},
			fail: function():Void {}
		});
	}

	/**
	 * 重力事件实现
	 * @param data
	 */
	private function onAccelerometerChange(data:Dynamic):Void {
		var deviceEvent:DeviceMotionEvent = new DeviceMotionEvent();
		deviceEvent.interval = 20;
		deviceEvent.accelerationIncludingGravity = data;
		_window.triggerEvent("devicemotion", deviceEvent);
	}

	/**
	 * 展示
	 */
	private function onShow(e):Void {
		trace("update ShowQuery=", e);
		untyped window.showQuery = e;
		_window.triggerEvent("focus");
		#if meituan
		untyped LXAnalytics("pageView", {
			'custom': {
				"inner_source": untyped mt.getLaunchOptionsSync().scene
			}
		}, {}, "c_game_4zk2nelx");
		#elseif tt
		// 判断是否从侧边栏进入，获得奖励判断
		var data:Dynamic = untyped window.showQuery;
		if (data != null && data.launch_from == "homepage" && data.location == "sidebar_card") {
			untyped window.isSidebarCardEnter = true;
		}
		#elseif ks
		// 判断是否从侧边栏进入，获得奖励判断
		var data:Dynamic = untyped window.showQuery;
		trace("ks showQuery:", data);
		if (data != null && data.from == "sidebar_new") {
			untyped window.isSidebarCardEnter = true;
		}
		#end
		// 常亮设置，兼容IOS处理，因为IOS缩小小游戏后，会自动关闭常亮，需要重新开启
		if (Wx.setKeepScreenOn != null)
			Wx.setKeepScreenOn({
				keepScreenOn: true
			});
	}

	/**
	 * 隐藏
	 */
	private function onHide():Void {
		_window.triggerEvent("blur");
		clearTouchStart();
		#if meituan
		untyped LXAnalytics("pageDisappear", {}, "c_game_4zk2nelx");
		#end
	}
}
