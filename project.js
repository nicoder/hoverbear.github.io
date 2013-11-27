/*jslint browser:false*/
/*globals Snap,alert,window,document,mina*/

document.addEventListener('DOMContentLoaded', function () {
    'use strict';
    // This is basically fun.
    var snap = new Snap(window.innerWidth, window.innerHeight),
        bug = snap.circle(100, 100, 50);
    bug.click(function () {
        var r = Math.floor(Math.random() * (window.innerWidth / 4)) + 10,
            cx = Math.floor(Math.random() * (window.innerWidth - (r * 2))) + r,
            cy = Math.floor(Math.random() * (window.innerHeight - (r * 2))) + r,
            time = Math.floor(Math.random() * 600 + 100),
            fill = Snap.getRGB("rgb(" +
                    Math.floor(Math.random() * 255) + ',' +
                    Math.floor(Math.random() * 255) + ',' +
                    Math.floor(Math.random() * 255) +
                    ")"
                );
        this.animate({
            'r': r,
            'cy': cy,
            'cx': cx,
            'fill': fill.hex
        }, time, mina.easein);
    });
});
