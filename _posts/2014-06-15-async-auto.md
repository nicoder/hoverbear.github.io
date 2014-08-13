---
layout: post
title: Async Auto
---

I've been exploring the handy [`async`](https://github.com/caolan/async) over the last few days in the lab. One of my projects is a MongoDB API Adapter in Node.js and I was pleased by a novel way of handling control flow.

[`async.auto()`](https://github.com/caolan/async#autotasks-callback) is a function offered by the libary which allows you to declare a set of tasks and their dependencies, then the library determines the best way to compose the initialization.

Consider the following dependency graph:

<svg width="100%" height="200px" viewBox="0 0 1344 386" version="1.1">
    <defs></defs>
    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="Rectangle-2-+-Database-Connection" transform="translate(390.000000, 44.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="Database-Connection" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="13.025" y="37">Database Connection</tspan>
            </text>
        </g>
        <g id="Rectangle-2-+-Database-Connection-4" transform="translate(708.000000, 44.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="Setup-Schemas" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="44.374" y="37">Setup Schemas</tspan>
            </text>
        </g>
        <g id="Rectangle-2-+-Database-Connection-5" transform="translate(1026.000000, 97.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="Build-Routes" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="58.082" y="37">Build Routes</tspan>
            </text>
        </g>
        <g id="Rectangle-2-+-Database-Connection-6" transform="translate(1026.000000, 281.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="Listen" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="92.559" y="37">Listen</tspan>
            </text>
        </g>
        <g id="Rectangle-2-+-Database-Connection-2" transform="translate(390.000000, 152.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="HTTP-Setup" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="64.292" y="37">HTTP Setup</tspan>
            </text>
        </g>
        <g id="Rectangle-2-+-Database-Connection-3" transform="translate(708.000000, 152.000000)">
            <rect id="Rectangle-2" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="HTTP-Middleware" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="33.794" y="37">HTTP Middleware</tspan>
            </text>
        </g>
        <g id="Rectangle-3-+-Init-2" transform="translate(72.000000, 97.000000)">
            <rect id="Rectangle-3" stroke="#979797" fill="#D8D8D8" x="0" y="0" width="249" height="57" rx="8"></rect>
            <text id="Init" font-family="Fira Sans" font-size="23" font-weight="normal" fill="#000000">
                <tspan x="107.4625" y="36">Init</tspan>
            </text>
        </g>
        <path d="M319.5,100.5 L389.5,68.5" id="Line" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-decoration-1" d="M388.62006,68.9022582 C384.745699,69.5188819 381.424818,70.0474165 377.550457,70.6640402 C378.423552,72.5739366 379.17192,74.2109907 380.045015,76.1208871 C383.046281,73.594367 385.618794,71.4287783 388.62006,68.9022582 C388.62006,68.9022582 388.62006,68.9022582 388.62006,68.9022582 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M319.5,150.5 L390.5,183.5" id="Line-2" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-2-decoration-1" d="M390.233104,183.37595 C387.247829,180.830554 384.689023,178.648786 381.703749,176.103391 C380.818627,178.007744 380.059951,179.640046 379.17483,181.544399 C383.045226,182.185442 386.362708,182.734907 390.233104,183.37595 C390.233104,183.37595 390.233104,183.37595 390.233104,183.37595 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M637.5,67.5 L707.5,67.5" id="Line-3" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-3-decoration-1" d="M707.5,67.5 C703.72,66.45 700.48,65.55 696.7,64.5 C696.7,66.6 696.7,68.4 696.7,70.5 C700.48,69.45 703.72,68.55 707.5,67.5 C707.5,67.5 707.5,67.5 707.5,67.5 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M637.5,184.5 L707.5,184.5" id="Line-4" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-4-decoration-1" d="M707.5,184.5 C703.72,183.45 700.48,182.55 696.7,181.5 C696.7,183.6 696.7,185.4 696.7,187.5 C700.48,186.45 703.72,185.55 707.5,184.5 C707.5,184.5 707.5,184.5 707.5,184.5 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M1151.5,152.5 L1151.5,282.5" id="Line-7" stroke="#000000" stroke-linecap="square" fill="#000000" transform="translate(1151.500000, 217.500000) scale(-1, 1) translate(-1151.500000, -217.500000) "></path>
        <path id="Line-7-decoration-1" d="M1151.5,282.5 C1152.55,278.72 1153.45,275.48 1154.5,271.7 C1152.4,271.7 1150.6,271.7 1148.5,271.7 C1149.55,275.48 1150.45,278.72 1151.5,282.5 C1151.5,282.5 1151.5,282.5 1151.5,282.5 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M957.5,183.5 L1028.5,151.5" id="Line-5" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-5-decoration-1" d="M1027.69944,151.860814 C1023.82185,152.456745 1020.49819,152.967544 1016.62059,153.563475 C1017.48348,155.478005 1018.2231,157.119031 1019.08598,159.033561 C1022.10069,156.5231 1024.68473,154.371276 1027.69944,151.860814 C1027.69944,151.860814 1027.69944,151.860814 1027.69944,151.860814 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path d="M957.5,72.5 L1026.5,99.5" id="Line-6" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
        <path id="Line-6-decoration-1" d="M1026.41197,99.4655518 C1023.27449,97.1103173 1020.58522,95.0915449 1017.44774,92.7363105 C1016.6825,94.6919203 1016.02658,96.3681573 1015.26135,98.3237672 C1019.16406,98.7233918 1022.50925,99.0659272 1026.41197,99.4655518 C1026.41197,99.4655518 1026.41197,99.4655518 1026.41197,99.4655518 Z" stroke="#000000" stroke-linecap="square" fill="#000000"></path>
    </g>
</svg>

With `async` this could be modelled like so:

```javascript
	(function init() {
		async.auto({
			dbConn: dbConn,
			schemas: [ 'dbConn', schemas ],
			http: http,
			httpMiddleware: [ 'http', httpMiddleware ],
			routes: [ 'http', 'schemas', routes ]
		}, listen);

		// Definitions of functions below.
	}());
```

The first parameter of the function is an object of tasks. They follow the format `taskName: function` or `taskName: [dependencies, function]`. Tasks with dependencies will only start when those have been resolved.

So async helps with the handling of dependencies, but can we handle dependant state?

For example, `dbConn` produces a `connection` variable, and `schemas` consumes it. The two functions look like this:

```javascript
	function dbConn(callback) {
		var connection = db.connect(someString).connection
		connection.on('success', function () {
			// Return `connection` into the `results`
			callback(null, connection);
		});
		connection.on('error', function (error) {
			callback(error, null);
		});
	}

	function schemas(callback, results) {
		// Do a bunch of stuff.
		// results.dbConn has the connection.
		callback(null);
	}
```

The result values of any task which another depends on are populated into the `results` parameter.

Finally, the `listen` function accepts a final `(error, results)`. Note it's called as soon as **any** task returns an error, so always make sure to handle errors. Finally, `results` will have all of the return values of the tasks which were composed.

This provides a compelling way to handle composability and dependencies without having to deal with complex callback changes. Functions will be invoked as their dependencies are resolved, and it's easy to add or remove dependencies, changing what's available in `results`.

Give this pattern a try, it's especially useful when combined with other functions available in `async`, like [`async.seq`](https://github.com/caolan/async#seq).
