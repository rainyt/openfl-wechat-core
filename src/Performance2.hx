/*
 * Copyright (c) 2023 YuTian.Liu FanYun
 */

import haxe.Timer;

/**
 * window.performance的实现支持
 */
class Performance2 {
	public function new() {}

	public function now():Float {
		#if (ks || meituan)
		var _time = Timer.stamp() * 1000;
		return _time;
		#else
		if (Window.platform == 'devtools')
			return Wx.getPerformance().now();
		#if qqquick
		if (Window.platform == "android") {
			return Wx.getPerformance().now();
		}
		return Std.int(Wx.getPerformance().now() / 1000);
		#elseif qihoo
		// 360使用的是毫秒
		return Std.int(Wx.getPerformance().now());
		#else
		return Std.int(Wx.getPerformance().now() / 1000);
		#end
		#end
	}
}
