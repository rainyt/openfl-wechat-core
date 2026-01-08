
class GC {

    public static function cleanup():Void
    {
        try{
            if(Wx.triggerGC != null)
            {
                Wx.triggerGC();
            }
        }
        catch(e:Dynamic)
        {

        }
    }
    
}