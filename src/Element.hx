@:expose
class Element extends EventElement {

    public var style:Style;

    public var width:Float = 0;

    public var height:Float = 0;

    public function new(){
        super();
        style = new Style();
    }

}

/**
 * 样式
 */
class Style {

    public function new(){

    }
    
    public function setProperty(a:Dynamic,b:Dynamic,c:Dynamic):Void
    {

    }

}