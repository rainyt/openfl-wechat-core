import lime.utils.Assets;

@:keep
class WxCore {

    public static var assets:Dynamic = untyped $hx_exports["lime_utils_AssetLibrary"]=lime_utils_AssetLibrary;
    public static var version:Dynamic = untyped $hx_exports["lime_utils_Assets_cache_version"]=WxCore.assetsVersion;

    public static function main()
    {
        Wx.createSound();
    }

    public static function assetsVersion():Int
    {
        return Assets.cache.version;
    }

}