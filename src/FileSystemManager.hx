extern class FileSystemManager {

    /**
     * 文件写入
     * @param data 
     */
    public function writeFile(data:Dynamic):Void;

    /**
     * 判断文件或者目录是否存在
     * @param data 
     */
    public function access(data:Dynamic):Void;

    /**
     * 判断文件或者目录知否存在，同步版
     * @param path 
     */
    public function accessSync(path:String):Bool;

    /**
     * 读取文件
     * @param data 
     */
    public function readFile(data:Dynamic):Void;

    /**
     * 同步读取文件
     * @param data 
     * @return Dynamic
     */
    public function readFileSync(data:Dynamic):Dynamic;

    /**
     * 储存临时文件
     * @param data 
     */
    public function saveFile(data:Dynamic):Void;
}