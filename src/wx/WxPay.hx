package wx;

/**
 * 购买接口
 */
class WxPay {
    
    public static function pay(payid:Int,onBuy:Int->Bool->Void):Void
    {
        untyped __js__("window.pay")(payid,function(bool:Bool):Void{
            onBuy(payid,bool);
        });
    }

}
