import wx.WxUtils;
import zygame.cmnt.data.BaseUserData;
import zygame.cmnt.API;
import zygame.cmnt.v3.V3Api;
import zygame.cmnt.callback.CmntCallBackData;

import zygame.utils.Lib;

@:keep
class UserData implements BaseUserData {
	/**
	 * 通过用户数据方法创建获取
	 */
	public static var userInfo:Dynamic = {guest: true};

	private static var _resettime:Int = 0;

	public function new() {
		#if !disable_auto_openid
		#if (weixin || qqquick || bili || g4399 || tt)
		resetGetOpenID();
		#end
		#end
	}

	@:deprecated("resetGetOpenID该接口即将弃用，因为不安全")
	public function resetGetOpenID():Void {
		_resettime++;
		trace("resetGetOpenID");
		if (_resettime > 5) {
			trace("重试了5次，不再请求");
			if (WxUtils.onResetGetOpenIDFail != null)
				WxUtils.onResetGetOpenIDFail();
			return;
		}
		getOpenIdFormCode(function(openid:String):Void {
			trace("OpenID:", openid);
			if (openid == null)
				resetGetOpenID();
			else {
				// 侦听openid下发成功事件
				if (WxUtils.onResetGetOpenID != null)
					WxUtils.onResetGetOpenID(openid);
				Wx.getSetting({
					success: function(ref:Dynamic):Void {
						if (Reflect.getProperty(ref.authSetting, "scope.userInfo") == true) {
							wx.WxUtils.createUserInfoData(function(bool:Bool):Void {
								trace("用户信息获取：", bool);
								untyped window.scope_userInfo = true;
							});
						} else {
							untyped window.scope_userInfo = false;
							trace("用户信息未授权，无法获取");
						}
					},
					fail: function(err:Dynamic):Void {
						trace("用户信息获取错误：" + err);
					}
				});
			}
		});
	}

	/**
	 * 获取用户ID，唯一ID
	 * @return String
	 */
	public function getOpenID():String {
		if (userInfo.openid == null)
			return null;
		#if qqquick
		if (wx.WxUtils.getPlatform() == "ios")
			return "ios_" + userInfo.openid;
		else
			return userInfo.openid;
		#else
		return userInfo.openid;
		#end
	}

	/**
	 * 获取用户名
	 * @return String
	 */
	public function getNickName():String {
		return userInfo.nickName;
	}

	/**
	 * 获取游戏用户token
	 * @return String
	 */
	public function getAccessToken():String {
		return userInfo.accessToken;
	}

	/**
	 * 获取头像地址
	 * @return String
	 */
	public function getAvatar():String {
		return userInfo.avatar;
	}

	/**
	 * 获取性别女=0，男=1，保密=2
	 * @return String
	 */
	public function getSex():String {
		if (userInfo.sex == 0)
			return "2";
		return userInfo.sex == 1 ? "1" : "0";
	}

	/**
	 * 是否为游客模式
	 * @return Bool
	 */
	public function isGuest():Bool {
		return userInfo.guest != false;
	}

	/**
	 * 是否 同意《用户协议》与《隐私政策》
	 * @return Bool
	 */
	public function isAgree():Bool {
		var isAgree = Lib.getData("isAgree");//新用户首次进入游戏需弹窗《用户协议》与《隐私政策》

		if(isAgree==false){

		}

		return isAgree;
	}

	/**
	 * 通过第三方登录微信流程
	 * @param cb 
	 */
	public static function loginWechat(cb:CmntCallBackData->Void):Void{
		Wx.login({
			success: function(res:Dynamic):Void {
				trace("login success = ", res);
				V3Api.jscode2sessionLogin(res.code,(data)->{
					//
					UserData.userInfo.session_key = data.obj.data.session_key;
					UserData.userInfo.openid = data.obj.data.openId;
					UserData.userInfo.accessToken = data.obj.data.extra?.accessToken;
					cb(data);
				});
			}, fail:function(err:Dynamic):Void {
				trace("登录错误：" + err);
				cb(null);
			}
		});
	}

	/**
	 * 获取OPENID入口
	 */
	public static function getOpenIdFormCode(cb:String->Void):Void {
		Wx.login({
			success: function(res:Dynamic):Void {
				trace("login success = ", res);
				#if g4399
				UserData.userInfo.openid = res.uid;
				cb(res.uid);
				return;
				#end
				var map:Map<String, String> = new Map<String, String>();
				#if bili
				map.set("bl_appid", untyped window.biliappid);
				map.set("secret", untyped window.SCRECT);
				// #elseif qqquick 手Q将使用v3的OpenId获取
				// map.set("sq_appid", untyped window.APPID);
				// map.set("sq_secret", untyped window.SCRECT);
				#elseif baidu
				map.set("client_id", untyped window.APPKEY);
				map.set("sk", untyped window.SCRECT);
				#else
				// map.set("appId", untyped window.APPID);
				// map.set("secret", untyped window.SCRECT);
				#end
				trace("登录成功：", res);
				#if baidu
				map.set("code", res.code);
				#elseif tt
				map.set("code", res.code);
				map.set("anonymousCode", res.anonymousCode);
				#else
				map.set("jsCode", res.code);
				// map.set("grantType", "authorization_code");
				#end
				#if bili
				API.getAPI("user/api/bilibili/jscode2session", map, function(data:CmntCallBackData):Void {
				#elseif baidu
				API.getAPI("user/api/baidu/code2session", map, function(data:CmntCallBackData):Void {
				#elseif qqquick
				// 2022.1.6 升级到v3接口
				V3Api.getAPI("third/nl/qq/jscode2session", map, function(data:CmntCallBackData):Void {
				// API.getAPI("user/api/sq/sqMiniGameCode2session", map, function(data:CmntCallBackData):Void {
					// API.getAPI("user/api/sq/code2session", map, function(data:CmntCallBackData):Void {
				#elseif tt
				V3Api.getAPI("third/nl/zhijie/code2session", map, function(data:CmntCallBackData):Void {
				// #elseif meituan
				// V3Api.getAPI("third/nl/meituan/jscode2sessionLogin", map, function(data:CmntCallBackData):Void {
				#else
				V3Api.getAPI("third/nl/wechat/jscode2session", map, function(data:CmntCallBackData):Void {
					// API.getAPI("user/api/weixin/jscode2session", map, function(data:CmntCallBackData):Void {
				#end
					trace("openid data:", data.data);
					if (data != null && data.code == 0) {
						// 储存openid;
						UserData.userInfo.session_key = data.obj.data.session_key;
						UserData.userInfo.openid = data.obj.data.openid;

						// 成功获取OPENID
						cb(data.obj.data.openid);
					} else {
						cb(null);
					}
				}
			);
			}, fail:function(err:Dynamic):Void {
				trace("登录错误：" + err);
				cb(null);
			}
		});

}}
