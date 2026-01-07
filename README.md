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
1、音频支持比较弱，可以说没有，可采取common/media/Sound & SoundChannel API代替；或自行实现。
2、遮罩可能失效？