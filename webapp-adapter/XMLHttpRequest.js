import EventTarget from './EventTarget.js'

const _url = new WeakMap()
const _method = new WeakMap()
const _requestHeader = new WeakMap()
const _responseHeader = new WeakMap()
const _requestTask = new WeakMap()

const fs = wx.getFileSystemManager()

String.prototype.myReplace = function (f, e) {//吧f替换成e
    var reg = new RegExp(f, "g"); //创建正则RegExp对象   
    return this.replace(reg, e);
}
// 网络资源转换为本地资源
function changLocaName(path) {
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
}


// 缓存图片
function saveCache(data, path,encoding,call) {
    // console.log("开始缓存:",path,encoding);
    var fileFull = changLocaName(path);
    // console.log("path:"+fileFull);
    if (!fileFull) 
    {
        call();
        return;  
    }
    fs.access({
        path: fileFull,
        success: function (res) {
            // console.log("资源存在");
            call();
        },
        fail: function (res) {
            // console.log("资源不存在");
            fs.writeFile({
                encoding: encoding,
                filePath: fileFull,
                data: data,
                success: function (res) {
                    // console.log("缓存成功：" + fileFull + ",encoding="+encoding);
                    call();
                }
            })
        }
    });


}
function readCache(url, cb) {
    var locaName = changLocaName(url);
    if (locaName == null) { cb(false, url); return; };
    fs.access({
        path: locaName,
        success: function (res) {
            // console.log("存在");
            cb(true, locaName)
        },
        fail: function (res) {
            // console.log("不存在");
            cb(false, locaName)
        }
    });
}

function _triggerEvent(type, event = {}) {
    event.target = event.target || this

    if (typeof this[`on${type}`] === 'function') {
        this[`on${type}`].call(this, event)
    }
}

function _changeReadyState(readyState, event = {}) {
    this.readyState = readyState

    event.readyState = readyState;

    _triggerEvent.call(this, 'readystatechange', event)
}

function _isRelativePath(url) {
    return !(/^(http|https|ftp|wxfile):\/\/.*/i.test(url));
}

export default class XMLHttpRequest extends EventTarget {

    constructor() {
        super();

        /*
         * TODO 这一批事件应该是在 XMLHttpRequestEventTarget.prototype 上面的
         */
        this.onabort = null
        this.onerror = null
        this.onload = null
        this.onloadstart = null
        this.onprogress = null
        this.ontimeout = null
        this.onloadend = null

        this.onreadystatechange = null
        this.readyState = 0
        this.response = null
        this.responseText = null
        this.responseType = ''
        this.responseXML = null
        this.status = 0
        this.statusText = ''
        this.upload = {}
        this.upload.addEventListener = function () { }
        this.withCredentials = false

        _requestHeader.set(this, {
            'content-type': 'application/x-www-form-urlencoded'
        })
        _responseHeader.set(this, {})
    }

    abort() {
        const myRequestTask = _requestTask.get(this)

        if (myRequestTask) {
            myRequestTask.abort()
        }
    }

    getAllResponseHeaders() {
        const responseHeader = _responseHeader.get(this)

        return Object.keys(responseHeader).map((header) => {
            return `${header}: ${responseHeader[header]}`
        }).join('\n')
    }

    getResponseHeader(header) {
        return _responseHeader.get(this)[header]
    }

    open(method, url /* async, user, password 这几个参数在小程序内不支持*/) {
        _method.set(this, method)
        _url.set(this, url)
        _changeReadyState.call(this, XMLHttpRequest.OPENED)
    }

    overrideMimeType() { }

    send(data = '') {
        if (this.readyState !== XMLHttpRequest.OPENED) {
            throw new Error("Failed to execute 'send' on 'XMLHttpRequest': The object's state must be OPENED.")
        } else {
            var url = _url.get(this)
            //非HTTP格式，应移除远程载入
            if(url.indexOf("http") == -1 && url.indexOf("?") != -1){
                url = window.webPath + "/" + url;
            }
            const header = _requestHeader.get(this)
            const responseType = this.responseType
            const relative = _isRelativePath(url)

            //读取编码
            let encoding;
            if (responseType === 'arraybuffer') {
                //读取二进制试用
                encoding = 'binary'
            } else {
                encoding = 'utf8'
            }

            // console.log("XMLHttp加载："+url);

            delete this.response;
            this.response = null;

            const onSuccess = ({ data, statusCode, header }) => {
                statusCode = statusCode === undefined ? 200 : statusCode;
                if (typeof data !== 'string' && !(data instanceof ArrayBuffer)) {
                    try {
                        data = JSON.stringify(data)

                    } catch (e) {
                        data = data
                    }
                }
                this.status = statusCode
                if (header) {
                    _responseHeader.set(this, header)
                }
                _triggerEvent.call(this, 'loadstart')
                _changeReadyState.call(this, XMLHttpRequest.HEADERS_RECEIVED)
                _changeReadyState.call(this, XMLHttpRequest.LOADING)

                this.response = data
                
                if (data instanceof ArrayBuffer) {
                    Object.defineProperty(this, 'responseText', {
                        enumerable: true,
                        configurable: true,
                        get: function () {
                            throw "InvalidStateError : responseType is " + this.responseType;
                        }
                    });
                } else {
                    this.responseText = data
                }
                var gthis = this;
                // 存储文件
                saveCache(data, url,encoding,function(){
                    _changeReadyState.call(gthis, XMLHttpRequest.DONE)
                    _triggerEvent.call(gthis, 'load')
                    _triggerEvent.call(gthis, 'loadend')
                });
                
            };
            onSuccess.bind(this);
            const onFail = ({ errMsg }) => {
                // TODO 规范错误

                if (errMsg.indexOf('abort') !== -1) {
                    _triggerEvent.call(this, 'abort')
                } else {
                    _triggerEvent.call(this, 'error', {
                        message: errMsg
                    })
                }
                _triggerEvent.call(this, 'loadend')

                if (relative) {
                    // 用户即使没监听error事件, 也给出相应的警告
                    console.warn(errMsg)
                }
            }

            readCache(url, function (b, loca) {
                if (b) {
                    var options = {
                        'filePath': loca,
                        'success': onSuccess,
                        'fail': onFail
                    }
                    //二进制binary不需要传入，如果传入会读取出文本编码
                    if (encoding && encoding != "binary") {
                        options['encoding'] = encoding;
                    }
                    fs.readFile(options)
                } else {
                    wx.request({
                        data,
                        url: url,
                        method: _method.get(this),
                        header: header,
                        responseType: responseType,
                        success: onSuccess,
                        fail: onFail
                    })
                }
            }.bind(this));
        }
    }

    setRequestHeader(header, value) {
        const myHeader = _requestHeader.get(this)

        myHeader[header] = value
        _requestHeader.set(this, myHeader)
    }

    addEventListener(type, listener) {
        if (typeof listener !== 'function') {
            return;
        }

        this['on' + type] = (event = {}) => {
            event.target = event.target || this
            listener.call(this, event)
        }
    }

    removeEventListener(type, listener) {
        if (this['on' + type] === listener) {
            this['on' + type] = null;
        }
    }
}

// TODO 没法模拟 HEADERS_RECEIVED 和 LOADING 两个状态
XMLHttpRequest.UNSEND = 0
XMLHttpRequest.OPENED = 1
XMLHttpRequest.HEADERS_RECEIVED = 2
XMLHttpRequest.LOADING = 3
XMLHttpRequest.DONE = 4
