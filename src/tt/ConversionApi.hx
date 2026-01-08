package tt;

import haxe.Json;
import Date;
import openfl.net.URLLoader;
import openfl.net.URLLoaderDataFormat;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.net.URLVariables;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;

/**
 * 字节专用回传API
 * https://event-manager.oceanengine.com/docs/8650/quickapp#二、快应用API回传产品使用介绍
 * 根据抖音快应用API回传文档实现
 */
class ConversionApi {
	public function new() {}

	private static var instance:ConversionApi;

	// 根据文档，回传接口地址应为固定值
	private var baseUrl:String = "https://analytics.oceanengine.com/api/v2/conversion";

	/**
	 * 获取单例实例
	 */
	public static function getInstance():ConversionApi {
		if (instance == null) {
			instance = new ConversionApi();
		}
		return instance;
	}

	/**
	 * 点击事件的回调处理
	 * @return String
	 */
	public function getClickId():String {
		var launchOpt:Dynamic = Wx.getLaunchOptionsSync();
		trace("launchOpt", launchOpt);
		if (launchOpt != null && launchOpt.query != null && launchOpt.query.clickid != null) {
			Wx.setStorageSync("clickid", launchOpt.query.clickid);
			return launchOpt.query.clickid;
		}
		return Wx.getStorageSync("clickid");
	}

	/**
	 * 发送回传事件（根据抖音快应用规范）
	 * @param eventType 事件类型，如 "active" 等
	 * @param clickId 从启动参数中获取的clickid
	 * @param callback 回调函数，格式为(error, response) -> Void
	 */
	public function postConversion(eventType:String, ?properties:Map<String, Dynamic>, ?callback:String->Dynamic->Void):Void {
		var clickId:String = getClickId();
		if (clickId == null) {
			if (callback != null) {
				trace("ConversionApi.postCustomData: customData不能为空");
				callback("非广告用户", null);
			}
			return;
		}
		if (eventType == null || eventType == "") {
			if (callback != null) {
				trace("ConversionApi.postCustomData: customData不能为空");
				callback("eventType不能为空", null);
			}
			return;
		}

		if (clickId == null || clickId == "") {
			if (callback != null) {
				trace("ConversionApi.postCustomData: clickId不能为空");
				callback("clickId不能为空", null);
			}
			return;
		}

		var obj:Dynamic = {};
		if (properties != null)
			for (key => value in properties) {
				Reflect.setProperty(obj, key, value);
			}

		// 构建符合文档规范的数据结构
		var data:Dynamic = {
			"event_type": eventType,
			"context": {
				"ad": {
					"callback": clickId, // 根据文档，这里填写从启动参数获取的clickid
					"match_type": 0
				}
			},
			"properties": obj,
			"timestamp": Std.int(Date.now().getTime()) // 添加时间戳
		};

		trace("ConversionApi.postCustomData: ", data);

		// 复用postCustomData方法发送请求
		postCustomData(data, callback);
	}

	/**
	 * 发送自定义数据结构的回传事件
	 * 用于需要自定义额外字段的场景
	 * @param customData 自定义的完整数据结构
	 * @param callback 回调函数
	 */
	public function postCustomData(customData:Dynamic, callback:String->Dynamic->Void):Void {
		if (customData == null) {
			if (callback != null) {
				trace("ConversionApi.postCustomData: customData不能为空");
				callback("customData不能为空", null);
			}
			return;
		}

		try {
			var jsonData:String = Json.stringify(customData);

			var request:URLRequest = new URLRequest(baseUrl);
			request.method = URLRequestMethod.POST;
			request.contentType = "application/json";
			request.data = jsonData;

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;

			loader.addEventListener(Event.COMPLETE, function(event:Event) {
				try {
					var response:Dynamic = Json.parse(loader.data);
					if (callback != null) {
						callback(null, response);
					}
				} catch (e:Dynamic) {
					if (callback != null) {
						trace("ConversionApi.postCustomData: 解析响应数据失败: ", e);
						callback("解析响应数据失败: " + e, null);
					}
				}
			});

			loader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent) {
				if (callback != null) {
					trace("ConversionApi.postCustomData: 网络请求错误: ", event.text);
					callback("网络请求错误: " + event.text, null);
				}
			});

			// 开始加载请求
			loader.load(request);
		} catch (e:Dynamic) {
			if (callback != null) {
				trace("ConversionApi.postCustomData: 数据处理或发送失败: ", e);
				callback("数据处理或发送失败: " + e, null);
			}
		}
	}

	/**
	 * 设置基础URL
	 * @param url 基础URL
	 */
	public function setBaseUrl(url:String):Void {
		if (url != null && url != "") {
			baseUrl = url;
		}
	}

	/**
	 * 获取当前基础URL
	 */
	public function getBaseUrl():String {
		return baseUrl;
	}
}
