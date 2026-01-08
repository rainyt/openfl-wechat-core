# openfl-wechat-core
用于发布微信小游戏使用的发布框架（V2026-01-07重新维护）

# 使用方法
```xml
<project>
    <haxelib name="wechatcore"/>
    <set name="DEVICE_ORIENTATION" value="portrait"/>
</project>
```

# 中间库实现来源
本中间库是完全使用Haxe编写重新实现的。

# 已知缺陷
- 1、音频支持比较弱，可以说没有，可采取common/media/Sound & SoundChannel API代替；或自行实现。
- 2、遮罩可能失效？

# 项目API规避
- 1、不要使用BitmapData任何像素相关的API操作，如copyPixels等；
- 2、如果需要绘制任何图像，请使用BitmapData.disposeImage()，转为帧缓冲来渲染；

# 平台中间件支持
- 4399
- 百度小游戏
- 哔哩哔哩小游戏
- 微信小游戏
- 快手小游戏
- 美团小游戏
- 奇虎360小游戏
- QQ小游戏
- 字节抖音小游戏