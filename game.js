import './lib/howler.min.js'
import './index.js'
import core from './zygameui-dom.js'

if(window.isWebView != true){
    window.Window = Object;
    window.Image = core.Image;
    window.Canvas = core.Canvas;
    window.HTMLCanvasElement = core.HTMLCanvasElement;
    window.HTMLDocument = core.HTMLDocument;
    window.HTMLElement = core.HTMLElement;
    window.XMLHttpRequest = core.XMLHttpRequest;
    window.WebSocket = core.WebSocket;
    window.CanvasRenderingContext2D = core.CanvasRenderingContext2D;
}

window.canvas = core.Window.canvas;


// 微信bannerkey
window.bannerAdKey = '::SET_WX_BANNERKEY::';
// 微信banner 刷新频率
window.banner_hz = parseInt('::SET_WX_BANNER_HZ::');
// 微信视频广告key
window.videoAdKey = '::SET_WX_VIDEOKEY::';
// 显示广告
window.isBannerAd='::SET_IS_SHOWBABNERAD::';
// APP下一章跳转其他微信小游戏的ID
window.toId="::SET_WX_TOID::";
//远程路径
window.webPath='::SET_REMOTE_PATH::';
if(window.webPath == "null")
    window.webPath = null;

//平台兼容使用
window.onPlatformResume = null;
window.onPlatformPause = null;
window.changLocaName = function changLocaName(path) {
    if(!window.webPath)return;
    var ps = window.webPath.split("/");
    var sp = ps[ps.length - 1];
    // console.log("分割字符串"+sp);
    var path = path.split(sp+"/")[1];
    if (!path) return;
    var pathArr = path.split('/');
    var fileExg = pathArr[pathArr.length - 1];
    if (fileExg.indexOf(".json") != -1 || fileExg.indexOf(".xml") != -1 || fileExg.indexOf(".mp3") != -1 || fileExg.indexOf(".png") != -1 || fileExg.indexOf(".jpg") != -1 || fileExg.indexOf(".bin") != -1) {
        return wx.env.USER_DATA_PATH + "/" + path.myReplace("/", "_");
    } else {
        return null;
    }
};
//恢复接口实现
wx.onShow(function(){
	if(window.onPlatformResume)
		window.onPlatformResume();
});

setTimeout(function() {
    if (window.start) {
        window.start();
    }
}, 10);

import * as lime from '::APP_FILE::.js'
canvas.style.setProperty=function(a,b,c){};
//自定义加载路径
lime.lime_utils_AssetLibrary.prototype.__cacheBreak = function(path){
    if(window.webPath != null){
        var assetsVersion = lime.lime_utils_Assets_cache_version();
        path = window.webPath + '/' + path;
        if (path.indexOf ('?') > -1) {
            path += '&' + assetsVersion;
        } else {
            path += '?' + assetsVersion;
        }
    }
    return path;
}
lime.lime.embed ("::APP_FILE::", canvas, window.innerWidth, window.innerHeight, { parameters: {} });