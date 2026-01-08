package ;

/**
 * 微信插屏广告
 */
extern class InterstitialAd  {

    public function show():Void;

    public function load():Void;

    public function destroy():Void;

    public function onLoad(cb:Dynamic):Void;

    public function onError(cb:Dynamic):Void;

    public function onClose(cb:Dynamic):Void;

}