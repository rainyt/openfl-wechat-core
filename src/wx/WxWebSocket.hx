package wx;

extern class WxWebSocket {

    public function new();

    public function onClose(data:Dynamic):Void;

    public function onOpen(data:Dynamic):Void;

    public function onError(data:Dynamic):Void;

    public function onMessage(data:Dynamic):Void;

    public function send(data:Dynamic):Void;

    public function close(data:Dynamic):Void;
}