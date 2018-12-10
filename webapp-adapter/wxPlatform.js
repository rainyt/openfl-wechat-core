// 申请用户授权
// 获取用户信息
window.curPlatform = null;
// banner 广告
window.bannerAd = null;
// video 广告
window.videoAd = null;
window.reSetbanner = 0;
window.getUserInfo = function () {
    // wx.getUserInfo({
    //     withCredentials:false,
    //     success:function(res){
    //         if(res && res!=null && res!=''){
    //             //玩家昵称
    //             let uName = res.userInfo.nickName;
    //             // 玩家的openID
    //             let uOpenID = res.userInfo.openId;
    //             console.log("玩家信息："+uName+uOpenID);
    //         }
    //     }
    // })
    window.loadAd();

    //获取平台属性
    wx.getSystemInfo({
        complete: function (res) {
            var platform = "ios";
            if (res && res.platform && res.platform != null && res.platform != "") {
                platform = res.platform;
            }
            window.curPlatform = platform;
        }
    });


}

// 分享微信
window.share = function (content, path, cb) {
    wx.shareAppMessage({
        title: content,
        imageUrl: window.webPath + "/wxshare/" + path
    });

    let t1 = setTimeout(function () {
        if (typeof cb == "function") {
            cb();
        }
    }, 3000);
}

// 支付
window.pay = function (payid, cb) {
    let mun = 100;
    switch (payid) {
        case 1:
            mun = 100;
            break;
        case 2:
            mun = 300;
            break;
        case 3:
            mun = 600;
            break;
        case 4:
            mun = 800;
            break;
        case 5:
            mun = 1200;
            break;
    }
    wx.requestMidasPayment({
        mode: 'game',
        env: 1,
        offerId: "1450016983",
        currencyType: 'CNY',
        buyQuantity: mun,
        platform: 'android',
        zoneId: "1",
        success: function () {
            cb(true);

        },
        fail: function () {
            cb(false);
        }
    });
    // cb(true);
}
// 开启重力
window.startAccelerometer = function (cb) {
    wx.startAccelerometer({
        success: function (res) {
            console.log("微信重力感应开启成功");
            wx.onAccelerometerChange(function (res) {
                cb(res.x, res.y, res.z);
            });
        },
        fail: function (res) {
            console.log("微信重力感应开启失败");
        }
    })
}
// 开启重力
window.stopAccelerometer = function () {
    wx.stopAccelerometer({
        complete: function (res) {
            console.log("关闭微信重力感应");
        }
    })
}
// 加载广告
window.loadAd = function () {
    if(window.videoAdKey!='false')
    {
    window.videoAd = wx.createRewardedVideoAd({ adUnitId: window.videoAdKey });
    }
    if(window.bannerAdKey=='false')
    {
       return;
    }
    window.bannerAd = wx.createBannerAd({
        adUnitId: window.bannerAdKey, style: {
            left: 0,
            top: 0,
        }
    });


    window.bannerAd.onLoad(() => {
        console.log("banner拉取成功");
    });
    window.videoAd.onLoad(() => {
        console.log("视频拉取成功");
    });

    window.bannerAd.onError(err => {
        console.log("banner拉取失败：" + err)
    });
    window.videoAd.onError(err => {
        console.log("视频拉取失败：" + err)
    });
}


// 显示banner广告
window.showBannerAd = function () {
    if(window.bannerAdKey=='false')
    {
        return;
    }
    if(window.isBannerAd=='false')
    {
        window.isBannerAd='true';
    }
    let winSize = wx.getSystemInfoSync();
    window.bannerAd.style.width = winSize.screenWidth;
    window.bannerAd.style.top = winSize.screenHeight - window.bannerAd.style.realHeight;
    window.bannerAd.style.left = (winSize.screenWidth - window.bannerAd.style.realWidth) * 0.5;
    window.bannerAd.show().then(() => {
        // 刷新广告
        RefreshBanner();
    });

}
// 定时刷新banner广告
let RefreshBanner = function () {
    if(window.bannerAdKey=='false')
    {
        return;
    }
    if (window.banner_hz == 0)
        return;
    window.reSetbanner = setInterval(function () {
        console.log("定时刷新广告");
        let banner2 = wx.createBannerAd({
            adUnitId: window.bannerAdKey, style: {
                left: 0,
                top: 0
            }
        });

        banner2.onLoad(() => {
            window.bannerAd.destroy();
            window.bannerAd = banner2;
            let winSize = wx.getSystemInfoSync();
            window.bannerAd.style.width = winSize.screenWidth;
            window.bannerAd.style.top = winSize.screenHeight - window.bannerAd.style.realHeight;
            window.bannerAd.style.left = (winSize.screenWidth - window.bannerAd.style.realWidth) * 0.5;
            window.bannerAd.show();
        });
        window.bannerAd.onError(err => {
            clearInterval(window.reSetbanner);
        });

    }, window.banner_hz * 1000);
}
// 隐藏banner
window.closeBannerAd = function () {
    if(window.bannerAdKey=='false')
    {
        return;
    }
    if(window.isBannerAd=='true')
    {
        window.isBannerAd='false';
    }
    console.log("隐藏横版广告");
    window.bannerAd.hide();
    clearInterval(window.reSetbanner);
}

// 显示视频广告
window.showVideoAd = function (cb) {
    // 关闭banner
    window.closeBannerAd();
    window.videoAd.show().catch(err => {
        window.videoAd.load()
            .then(() => window.videoAd.show());
    });
    // 监听关闭or看完视频
    window.videoAd.onClose(res => {
        // 关闭监听
        window.videoAd.offClose(null);
        if(window.isBannerAd=='true')
        {
        window.showBannerAd();
        }
        if (res && res.isEnded || res === undefined) {
            // 正常播放结束，可以下发游戏奖励
            console.log("正常播放结束，可以下发游戏奖励");
            cb(true);
          }
          else {
              // 播放中途退出，不下发游戏奖励
              console.log("不下发游戏奖励");
              cb(false);
          }
    });
}
// 设备方向
window.startDeviceMotionListening = function(cb){
    wx.startDeviceMotionListening({
        success:function(res){
            wx.onDeviceMotionChange(function(res){
                cb(res.beta,res.gamma,res.alpha);
            })
        },
        fail:function(res){
             console.log(res);   
        }
    });
}

window.stopDeviceMotionListening = function(){
    wx.stopDeviceMotionListening({
        success:function(res){
            console.log("关闭方向监听");  
        },
        fail:function(res){
            console.log(res);   
        }
    })
}
//判断视频key是否存在返回给布尔
window.videoKeyIsOrNo = function () {
    if(window.videoAdKey=='false')
    {
        return false;
    }
    else
    {
        return true;
    }
}

// 跳转其他小程序
window.navigateToMiniProgram=function(){
    wx.navigateToMiniProgram({
        appId: window.toId,
        envVersion: 'release',
        success(res) {
          console.log("跳转成功");
        }
      })
}