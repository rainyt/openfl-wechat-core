# openfl-wechat-core
用于发布微信小游戏使用的发布框架

# 使用方法
`
在主类里导入WxCore类，比如：import WxCore;
然后在project.xml中添加	<haxelib name="wechatcore"/>以及	<set name="DEVICE_ORIENTATION" value="portrait"/>
DEVICE_ORIENTATION 屏幕方向
支持微信小游戏的常规方向，如：portrait
`

# 中间库实现来源

# 已知缺陷
1、音频支持比较弱，可以说没有，可采取common/media/Sound & SoundChannel API代替；或自行实现。
