/**
 * 本地储存
 */
class LocalStorage {
	public function new() {}

	public function key(n:String):Dynamic {
		var keys:Dynamic = Wx.getStorageInfoSync().keys;
		return untyped keys[n];
	}

	public function getItem(key:String):Dynamic {
		if (key == "")
			return null;
		var value:Dynamic = Wx.getStorageSync(key);
		return value == "" ? null : value;
	}

	public function setItem(key:String, value:Dynamic):Dynamic {
		// 2022.7.11 这里升级为异步
		// return Wx.setStorageSync(key, value);
		Wx.setStorage({
			key: key,
			data: value
		});
		return value;
	}

	public function removeItem(key:String):Void {
		// Wx.removeStorageSync(key);
	}

	public function clear():Void {
		Wx.clearStorageSync();
	}
}
