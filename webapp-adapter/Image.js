import * as Mixin from './util/mixin'
import HTMLImageElement from './HTMLImageElement'

export default function() {
    const image = wx.createImage();

    // image.__proto__.__proto__.__proto__ = new HTMLImageElement();

    if (!('tagName' in image)) {
        image.tagName = 'IMG'
    }

    Mixin.parentNode(image);
    Mixin.classList(image);

    // var _src = image.src.set;
    // Object.defineProperty(image, 'src', {
    //     enumerable: true,
    //     configurable: true,
    //     set: function (v) {
    //         console.log(image.__proto__.__proto__.__proto__);
    //         console.log("image path:"+v);
    //         image.__proto__.__proto__.__proto__.src = v;
    //     }
    // });

    return image;
};
