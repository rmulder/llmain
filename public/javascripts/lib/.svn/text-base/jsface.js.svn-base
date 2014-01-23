/**
 * jsface.js - jsFace Object Oriented Library.
 *
 * Copyright (c) 2009 - 2010 Tan Nhu. All rights reserved.
 *
 * Licensed under LGPL and GPL.
 *
 * @author <a href='tannhu@gmail.com'>Tan Nhu</a>.
 * $Date: Saturday, March 07 2009 $
 */
(function(){

	/**
	 * Namespace jsface is the root of jsface core.
	 * @namespace jsface.
	 */
	jsface = {};

	/**
	 * Execute a function when DOM is already.
	 * @param {Function} fn function to be executed.
	 * @param {String} description a desription used for debugging or logging (optional).
	 * @param {Object} args arguments of the function (optional).
	 * @alias jsface.ready.
	 */
	jsface.ready = function(fn, description, args){
		// Startup functions repository
		jsface.ready.funcs = jsface.ready.funcs || function(){
			// Define one time startup invoker
			jsface.ready.invoker = jsface.ready.invoker || function(){
				// Execute function, one by one
				jsface.each(jsface.ready.funcs, function(index, entry){
					entry.fn(entry.args);
				});

				// Cleanup ready(), I've done my job!
				delete jsface.ready.funcs;
				delete jsface.ready.invoker;
			};

			// Attach invoker to window.onload
			var old = window.onload;
			window.onload = jsface.isFunction(old) ? function(){
				old();
				jsface.ready.invoker();
			} : jsface.ready.invoker;

			// Return startup value for jsface.ready.funcs repository
			return [];
		}();

		// Add function into repository
		if (jsface.isFunction(fn)){
			jsface.ready.funcs.push({
				fn: fn,
				args: args,
				description: description
			});
		}
	};

	/**
	 * Create a namspace hierarchy.
	 * @param {String} namespace
	 * @return null if namespace is invalid. otherwise, return the namespace object.
	 * Example: var ns = namespace('com.jsface.widgets'); // ns becomes com.jsface.widgets
	 *
	 * If one namespace in chain exists, it will be reused.
	 * @alias jsface.namespace
	 */
	jsface.namespace = function(namespace){
		if (jsface.isString(namespace)){
			var names = namespace.split('.'), root, i, re = /^[a-zA-Z_$][0-9]*[a-zA-Z_$]*/;

			// Check each name using regular expression
			// Condition: Begin with an alphabet character, follow by alphabets or numbers
			for (i in names){
				if (re.test(names[i]) === false){
					return null;
				}
			}

			root = window;
			for (i in names){
				// Create if namespace does not exist
				if ( !root[names[i]]){
					root[names[i]] = {};
				}
				root = root[names[i]];
			}
			return root;
		}
		return null;
	};

	/**
	 * Make a class inherit a super class. Subclass may use _super to call super class constructor. I.e in
	 * subclass constructor, call super class constructor like: this.superConstructor(params);
	 *
	 * Note:
	 *  + superConstructor: parent constructor.
	 *  + superClass: parent prototype.
	 * If sub class wants to call parent method, use superClass. I.e: this.superClass.foo.call(this, ...);
	 *
	 * @param {Object} parent the parent class.
	 * @param {Object} child the sub class.
	 * @private
	 */
	function inherit(parent, child){
		if (parent && child){
			// Copy static properties from parent to child
			jsface.each(parent, function(key, fn){
				if (key !== 'prototype' && key !== 'constructor' && key !== 'classMeta'){
					child[key] = fn;
				}
			});

			// Child is not a static class: move on with its prototype
			if (child.prototype){
				// Copy prototype properties from parent to child
				jsface.each(parent.prototype, function(key, fn){
					child.prototype[key] = fn;
				});
				child.prototype.constructor = child;
				child.prototype.superClass = parent.prototype;
				child.prototype.superConstructor = parent.prototype.constructor;
			}
		}
		return child;
	}

	/**
	 * Make overloading method incase api is declared as an array.
	 * @param {String} methodName method name.
	 * @param {Array} api api declared as an array.
	 * @return {Function} function supports all declared overloadings.
	 * @throw {Exception} if there is an error in an overloading method.
	 * @private
	 */
	function makeOverloadingArray(methodName, api){
		// It is an array, check the length
		if (api.length === 0){
			return api;
		}

		// Ok, it is an array, check if it is not a method but a normal array property
		for (var idx in api){
			if ( !jsface.isFunction(api[idx])){
				return api;
			}
		}

		// Now it is an overloading method. If there is only one overloading, ignore wrapping
		if (api.length === 1){
			return api[0];
		}

		// Make wapper
		return function(){
			var len = arguments.length, defaultFn = null, idx;

			for (idx in api){
				if (api[idx].length === len){
					return api[idx].apply(this, arguments);
				} else if (api[idx].length === 0){
						defaultFn = api[idx];
				}
			}

			// Still not match? How about passing to the default method which does not declare any argument?
			if (defaultFn){
				return defaultFn.apply(this, arguments);
			} else { // No method supports arguments.length? Throw an exception
				throw (methodName + '() does not accept ' + len + ' arguments');
			}
		};
	}

	/**
	 * Make overloading method incase api is declared as an object.
	 * @param {String} methodName method name.
	 * @param {Object} api api declared as an object.
	 * @return {Function} function supports all declared overloadings.
	 * @throw {Exception} if there is an error in an overloading method.
	 * @private
	 */
	function makeOverloadingObject(methodName, api){
		/*
		 * Make evaluator function for an argument of a overriding function.
		 */
		function makeEvaluator(expression, typeDefsString){
			var s = "(function(){ return function(it){ return (" + expression + ") === true; }})();";
			try {
				return eval(s);
			} catch (error){
				throw "Invalid validating expression: " + expression + ' on overloading method ' + methodName + '(' + typeDefsString + ')';
			}
		}

		/*
		 * Transform types definition for a overriding function.
		 * typeDefs ~ ['string', 'string: it != null']
		 *	>>: [{ name: 'string', type: String },
		 *		   { name: 'String', type: String, expression: 'it != null', evaluator: function(it){ return (it != null) === true; }]
		 * @param typeDefs array of type definitions.
		 * @param typeDefsString the whole string represent types definition of the method.
		 */
		function transformTypes(typeDefs, typeDefsString){
			var result = [];

			jsface.each(typeDefs, function(index, typeDef){
				typeDef = jsface.trim(typeDef);
				var name, type, expression, evaluator, str, colon = typeDef.indexOf(':');

				if (colon === -1){
					name = typeDef;
				} else {
					name = typeDef.substring(0, colon);
					expression = typeDef.substring(colon + 1, typeDef.length);
					evaluator = makeEvaluator(expression, typeDefsString);
				}
				try {
					type = eval(name);
				} catch (error){
					throw "Type " + name + ' is not defined on overloading method ' + methodName + '(' + typeDefsString + ')';
				}
				result.push({
					name: name,
					type: type,
					expression: expression,
					evaluator: evaluator
				});
			});
			return result;
		}

		/*
		 * Determine type of an argument.
		 */
		function getType(obj){
			if (jsface.isString(obj)){
				return String;
			}
			if (jsface.isArray(obj)){
				return Array;
			}
			if (jsface.isNumber(obj)){
				return Number;
			}
			if (jsface.isFunction(obj)){
				return Function;
			}
			if (jsface.isBoolean(obj)){
				return Boolean;
			}

			// Try to guess obj is a class created by jsface
			try {
				if (jsface.isString(obj.classMeta.name)){
					return eval(obj.classMeta.name);
				}
			} catch (error){}

			// All other objects will be marked as Object type
			return Object;
		}

		/*
		 * Check that arguments passing to call function matches an overriding function or not.
		 */
		function isMatched(args, len, typeInfo){
			var i, type, name, arg;
			for (i = 0; i < len; i++){
				type = typeInfo[i].type;
				name = typeInfo[i].name;
				arg = args[i];

				if (getType(arg) !== type && !(arg === null && (type === String || type === Array || type === Object))){
					return false;
				}
			}
			return true;
		}

		/*
		 * Build method signature for debugging.
		 */
		function buildMethodSignature(typeItem, args, len){
			var s = methodName + '(', i;
			for (i = 0; i < len - 1; i++){
				s += typeItem.types[i].name + ': ' + args[i] + ', ';
			}
			s += typeItem.types[len - 1].name + ': ' + args[len - 1] + ')';
			return s;
		}

		/*
		 * Select an overriding function to execute function with passing arguments.
		 */
		function selectHandler(context, mapItem, len, args){
			var matches = [], typeItem, i, s;

			// Iterator over mapItem, if arguments match types definition, push matched meta in matches
			jsface.each(mapItem, function(index, item){
				if (isMatched(args, len, item.types)){
					matches.push(item);
				}
			});

			// There are more than one methods matched, check to remove methods which arguments do not pass evaluators
			if (matches.length > 1){
				jsface.each(matches, function(index, typeItem){
					for (i = 0; i < len; i++){
						var evaluator = typeItem.types[i].evaluator;
						if (evaluator){
							if (evaluator.call(context, args[i]) === false){
								matches.splice(index, 1);
							}
						}
					}
				});
			}

			// Only one method matched, great, it is the method for arguments
			if (matches.length === 1){
				typeItem = matches[0];
				for (i = 0; i < len; i++){
					var evaluator = typeItem.types[i].evaluator;
					if (evaluator){
						if (evaluator.call(context, args[i]) !== true){
							throw buildMethodSignature(typeItem, args, len) +
								'. Validating error at parameter ' + (i + 1) + ', expression: ' +
								typeItem.types[i].expression;
						}
					}
				}
				return typeItem.fn.apply(context, args);
			}

			// Prepare error message
			s = methodName + '(';
			for (i = 0; i < len - 1; i++){
				s += args[i] + ', ';
			}
			s += args[len - 1] + '). Check argument types and values.';

			// Something wrong here
			switch (matches.length){
				case 0:
					throw "No overloading method matches the call " + s;
				default:
					throw "Vague arguments on calling " + s;
			}
		}

		// Where to store all information about the method
		var overloadingsMeta = {};

		// Push default overloadingsMeta
		if (jsface.isFunction(api['0'])){
			overloadingsMeta['0'] = [{
				fn: api['0']
			}];
		}

		// Pre-check, and process types during the checking time
		for (var key in api){
			// Check for sure that the whole contents are key:function
			if (!jsface.isFunction(api[key])){
				return api;
			}

			// Skip checking default handler
			if (key === '0'){
				continue;
			}

			var typeDefs = key.split(','), f = api[key];

			// Check, types length != function parameters length
			if (typeDefs.length !== f.length){
				throw 'Invalid method declaration for ' + methodName + '() at overloading "' + key +
				'". Actual overloading parameters do not match with their types declaration.';
			}

			// Prepare overloadingsMeta[] for this function
			if (overloadingsMeta[typeDefs.length] === undefined){
				overloadingsMeta[typeDefs.length] = [];
			}

			// Transform typeDefs from array of string to array of object
			typeDefs = transformTypes(typeDefs, key);

			// Put method info (type declaration and function) into overloadingsMeta
			overloadingsMeta[typeDefs.length].push({
				types: typeDefs,
				fn: f
			});
		}

		// Make wrapper
		return function(overloadings){
			return function(){
				var len = arguments.length;

				if (overloadings[len] !== undefined){ // Match, delegate to selectHandler
					return selectHandler(this, overloadings[len], len, arguments);
				} else if (overloadings[0] !== undefined){ // Default handler
					return overloadings[0][0].fn.apply(this, arguments);
				} else { // No one matched, throw an exception
					throw methodName + '() does not accept ' + len + ' arguments';
				}
			};
		}(overloadingsMeta);
	}

	/**
	 * Make overloading methods.
	 *
	 * @param {Object} methodName method name or description, for debugging.
	 * @param {Object} api actual method implementation of the method.
	 * @return {Function} function supports all declared overloadings.
	 * @throw {Exception} if there is an error in an overloading method.
	 * @static
	 * @alias jsface.overload
	 */
	jsface.overload = function(methodName, api){
		if (jsface.isArray(api)){ // API as an array
			return makeOverloadingArray(methodName, api);
		} else if (jsface.isMap(api)){ // API as an object
			return makeOverloadingObject(methodName, api);
		} else { // Defauld, not a method, return as is
			return api;
		}
	};

	/**
	 * Define a class. If a class exists, it will be replaced.
	 *
	 * @param {Object} opts options.
	 * - opts.cls (String): class name.
	 * - opts.on (Object): namespace or package of this class. Default is no namespace.
	 * - opts.under (Object or Function): parent class. If no parent is specified, cls is top level class.
	 * - opts.plugins (Array): List of plugins.
	 * - opts.as (Function): api implementation.
	 * - opts.statics (Array): list of static methods in opts.as.
	 * @see ../test/core/coreTs.js#test def().
	 * @static
	 * @alias jsface.def
	 */
	jsface.def = function(opts){
		var api, cls, bindTo, index, f;

		opts.on = opts.on !== undefined ? opts.on : window;  // namespace/package
		opts.singleton = (opts.singleton === true);          // singleton ?
		api = opts.as();                                     // api() returns api object

		// Delete class if it exists
		if (opts.on[opts.cls]){
			delete opts.on[opts.cls];
		}

		// If singleton, constructor is an array, otherwise, point to cons if it is a function, if it is
		// not, create default constructor. api[opts.cls] points to constructor.
		opts.on[opts.cls] = opts.singleton ? {} : jsface.overload(opts.cls, api[opts.cls]);     // the constructor, if not specified, a default blank constructor is generated
		opts.on[opts.cls] = opts.on[opts.cls] === undefined ? function(){} : opts.on[opts.cls];
		cls = inherit(opts.under, opts.on[opts.cls]);                                           // the actual class
		bindTo = (opts.singleton === true) ? cls : cls.prototype;                               // the place where to bind api: obj or prototype

		// Bind APIs, Rules: Don't bind constructor (already bound)
		for (f in api){
			if (f !== opts.cls){
				bindTo[f] =  jsface.overload(opts.cls + '.' + f, api[f]);
			}
		}

		// Add class meta data
		cls.classMeta = {
			name: opts.cls,               // Class name, in String, i.e: 'Element'
			parent: opts.on,              // Parent class, qualified class is parent[name]
			singleton: opts.singleton     // singleton or not
		};

		// If class is not singleton, bind meta to prototype also
		if (opts.singleton !== true){
			cls.prototype.classMeta = cls.classMeta;
		}

		// Add plugins of class/object into it, plugins = [ 'plugin-a', 'plugin-b', ... ]
		for (index in opts.plugins){
			jsface.plug({ id: opts.plugins[index], on: bindTo });
		}

		// Call def()'s plugins to process other actions that default def() does not support over the class
		jsface.each(jsface.def.plugins, function(pluginName, pluginFn){
			pluginFn({
				cls: cls,        // the actual class
				bindTo: bindTo,  // where APIs are bound to (singleton: class, normal: prototype).
				api: api,        // api
				opts: opts       // options
			});
		});
	}

	/**
	 * def()'s plugins. The repository for def()'s processing plugins.
	 * @private
	 */
	jsface.def.plugins = {
		/*
		 * Plugin: statics.
		 * Purpose: Make some methods are static methods. They are available in both class and instance
		 * levels. I.e: Both jsface.Element.get() and jsface.Element element.get() are valid.
		 */
		statics: function(params){
			var	cls = params.cls,
				bindTo = params.bindTo,
				api = params.api,
				opts = params.opts;

			if ( !opts.singleton){
				jsface.each(opts.statics, function(index, fnName){
					cls[fnName] = bindTo[fnName];
				});
			}
		},

		/*
		 * Plugin: init.
		 * Purpose: Class level initialization.
		 */
		init: function(params){
			var	cls = params.cls,
				bindTo = params.bindTo,
				api = params.api,
				opts = params.opts;

			if (jsface.isFunction(opts.init)){
				opts.init();
			}
		}
	};

	/**
	 * Define a plugin. Plug a plugin into a class or object.
	 *
	 * @param {Object} opts options.
	 * - opts.on: class or object (an instance of a class or any object). If opts.on is no
	 *			specified, the plugin is defined and stored in global plugins repository (jsface.plugins)
	 *			and ready for use.
	 * - opts.as: api methods.
	 * @see ../test/core/coreTs.js#test plug().
	 * @static
	 * @alias jsface.plug
	 */
	jsface.plug = function(opts){
		jsface.plug.plugins = jsface.plug.plugins || {};	// Global plugins repositoty @private
		var id, obj, api, plugins = jsface.plug.plugins, fn;

		try {
			id = opts.id;
			obj = opts.on;
			api = opts.as;

			if (id !== undefined){
				// Store plugin into global plugins repository if both id and api are passed.
				// Otherwise, retrieve api from repository
				if (api !== undefined){
					plugins[id] = api;
				} else {
					api = plugins[id];
				}
			}

			// If obj is specified, plug the plugin into it
			if (obj !== undefined){
				// Check api exists or not
				if (api === undefined){
					throw 'Plugin ' + id + ' does not exist';
				}

				// Determine obj is a class or an instance of a class. If obj is a class, attach plugins
				// to its prototype, applicable for other instances , otherwise, attach plugins as
				// its own plugins only
				if (typeof obj === 'function'){
					obj = obj.prototype;
				}

				// Attach all functions in api into obj
				for (fn in api){
					obj[fn] = api[fn];
				}
			}
		} catch (error){
			throw "jsface.plug(): " + (jsface.browser.ie ? error.description : error);
		}
	};

	/**
	 * For each loop over a collection (a string, an array, an object (a map with pairs of {key:value})),
	 * or a function (over all static properties).
	 * + each(collection, fn)
	 * + each(collection, predicate, fn)
	 *
	 * If collection is a string or an array, predicate and fn are executed over each item as:
	 *    predicate(index, value)
	 *    fn(index, value)
	 * Otherwise, they are executed as:
	 *    predicate(key, value)
	 *    fn(key, value)
	 * In case predicate is specified, over each item when it returns true, fn will be executed, if not, fn is skipped.
	 *
	 * This each() function supports string, array, object, and function.
	 * @static
	 * @alias jsface.each
	 */
	jsface.each = function(){
		var len = arguments.length, collection, predicate, fn, item, isArray, isMap, isFunction, ret;

		switch (len){
			case 2: // just collection and function
				collection = arguments[0];
				fn = arguments[1];
				break;
			case 3: // collection, predicate and function
				collection = arguments[0];
				predicate = arguments[1];
				fn = arguments[2];
				break;
			default:
				return;
		}

		isArray = jsface.isArray(collection) || jsface.isString(collection);
		isMap = jsface.isMap(collection);
		isFunction = jsface.isFunction(collection);

		// Skip processing if collection is not String, Array, or Map
		if ( !isArray && !isMap && !isFunction){
			return;
		}

		// If no predicate is passed, execute fn over all elements
		// Otherwise, over the condition of predicate only
		if (len === 2){
			for (item in collection){
				ret = fn(item, collection[item]);
				if (ret === true){
					break;
				}
			}
		} else {
			for (item in collection){
				if (predicate(item, collection[item])){
					ret = fn(item, collection[item]);
					if (ret === true){
						break;
					}
				}
			}
		}
	};

	/**
	 * Merge data objects.
	 * + var m = merge(obj1, obj2, ...);
	 * Argument objects must be object ({}). Arguments won't be changed.
	 * The priority is right to left, parameters on the right have higher priority than
	 * parameters on the left. That means if there is one value duplicated, value of the
	 * right parameter will be used.
	 * @static
	 * @alias jsface.merge
	 */
	jsface.merge = function(){
		var	args = [].concat(Array.prototype.slice.apply(arguments)),
			result = null, first, second;

		switch (args.length){
			case 0:
			case 1:
				break;
			case 2:
				first = args[0] || {};
				second = args[1] || {};
				if (jsface.isMap(first) && jsface.isMap(second)){
					result = {};
					jsface.each(first, function(fKey, fValue){
						result[fKey] = fValue;
					});
					jsface.each(second, function(sKey, sValue){
						result[sKey] = sValue;
					});
				}
				break;
			default:
				first = args.shift();
				result = jsface.merge(first, jsface.merge.apply(jsface, args));
		}

		return result;
	};

	/**
	 * Check an object is a map or not. A map is something like { key1: value1, key2: value2 }.
	 * @param {Object} obj
	 * @return true if obj is a map. false if not.
	 * @static
	 * @alias jsface.isMap
	 */
	jsface.isMap = function(obj){
		return (obj && typeof obj === 'object' && !(typeof obj.length === 'number' && !(obj.propertyIsEnumerable('length'))));
	};

	/**
	 * Check an object is an array or not. An array is something like [].
	 * @param {Object} obj
	 * @return true if obj is an array. false if not.
	 * @static
	 * @alias jsface.isArray
	 */
	jsface.isArray = function(obj){
		return (obj && typeof obj === 'object' && typeof obj.length === 'number' && !(obj.propertyIsEnumerable('length')));
	};

	/**
	 * Check an object is a function or not.
	 * @param {Object} obj
	 * @return true if obj is a function. false if not.
	 * @static
	 * @alias jsface.isFunction
	 */
	jsface.isFunction = function(obj){
		return (obj && typeof obj === 'function');
	};

	/**
	 * Check an object is a string not.
	 * @param {Object} obj
	 * @return true if obj is a string. false if not.
	 * @static
	 * @alias jsface.isString
	 */
	jsface.isString = function(obj){
		return (obj === '' || (obj && typeof obj === 'string'));
	};

	/**
	 * Check an object is a boolean or not.
	 * @param {Object} obj
	 * @return true if obj is a boolean object. false if not.
	 * @static
	 * @alias jsface.isBoolean
	 */
	jsface.isBoolean = function(obj){
		return (typeof obj === 'boolean');
	};

	/**
	 * Check an object is a number or not.
	 * @param {Object} obj
	 * @return true if obj is a number. false if not.
	 * @static
	 * @alias jsface.isNumber
	 */
	jsface.isNumber = function(obj){
		return (typeof obj === 'number');
	};

	/**
	 * Check an object is undefined or not.
	 * @param {Object} obj
	 * @return true if obj is undefined. false if not.
	 * @static
	 * @alias jsface.isUndefined
	 */
	jsface.isUndefined = function(obj){
		return (obj === undefined);
	};

	/**
	 * Check an object is null or not.
	 * @param {Object} obj
	 * @return true if obj is null. false if not.
	 * @static
	 * @alias jsface.isNull
	 */
	jsface.isNull = function(obj){
		return (obj === null);
	};

	/**
	 * Check an object is null or undefined.
	 * @param {Object} obj object to check
	 * @return true if the object is null or undefined. false if not.
	 * @static
	 * @alias jsface.isNullOrUndefined
	 */
	jsface.isNullOrUndefined = function(obj){
		return (obj === undefined || obj === null);
	};

	/**
	 * Check an object is empty or not. An empty object is either null, undefined, '', [], or {}.
	 * A string contains blank spaces (blank, tab, etc.) also is treated as an empty string.
	 * @param {Object} obj object to check
	 * @return true if the object is empty.
	 * @static
	 * @alias jsface.isEmpty
	 */
	jsface.isEmpty = function(obj){
		return (obj === undefined || obj === null || (jsface.isString(obj) && jsface.trim(obj) === '')
				|| (jsface.isArray(obj) && obj.length === 0)
				|| (jsface.isMap(obj) && (function(ob){ for (var i in ob){ return false; } return true;	})(obj)));
	};

	/**
	 * Empty function.
	 * @static
	 * @alias jsface.emptyFn
	 */
	jsface.emptyFn = function(){
	};

	/**
	 * Browser checking flags.
	 * @static
	 * @alias jsface.browser
	 */
	jsface.browser = function(){
		var	ua = navigator.userAgent.toLowerCase(),
			check = function(r){
				return r.test(ua);
			},
			opera = check(/opera/),
			ie = check(/msie/),
			ie7 = ((navigator.appVersion.indexOf('MSIE 7.') === -1) ? false : true),
			ie8 = ((navigator.appVersion.indexOf('MSIE 8.') === -1) ? false : true),
			firefox = check(/firefox/),
			chrome = check(/chrome/),
			safari = !chrome && check(/safari/),
			name = opera ? 'Opera' : (ie ? 'IE' : (firefox ? 'Firefox' : (chrome ? 'Chrome' : (safari ? 'Safari' : 'Unknown'))));

		return {
			name: name,
			opera: opera,
			ie: ie,
			ie7: ie7,
			ie8: ie8,
			firefox: firefox,
			chrome: chrome,
			safari: safari,
			ua: ua
		};
	}();

	/* ASPECT ORIENTED PROGRAMMING */

	/**
	 *
	 * Wrapper a function with before, after functions around it.
	 * @param {Function} fn original function.
	 * @param {Function} before
	 * @param {Function} after
	 * @param {Boolean} seq sequential mode (true) or curly mode (other).
	 * @private
	 */
	function wrapper(fn, before, after, seq){
		return function(){
			// sequential mode. fn = before();r = fn();after();return r;
			if (seq === true){
				// Invoke before, if it returns false, skip fn() and after()
				if (before.apply(this, arguments) === false){
					return;
				}

				// Invoke fn, save return value
				var ret = fn.apply(this, arguments);

				// Invoke after()
				after.apply(this, arguments);

				// Return ret
				return ret;
			} else { // curly mode. fn = after(fn(before()))
				return after.apply(this, [fn.apply(this, [before.apply(this, arguments)])]);
			}
		};
	}

	/**
	 * Apply AOP into a class or object.
	 * opts.on: the class or object.
	 * opts.as: pointcuts.
	 * @param {Object} opts
	 * @static
	 * @alias jsface.pointcuts
	 */
	jsface.pointcuts = function(opts){
		if ( !opts || !opts.on || !opts.as || !opts.on.classMeta){ // Support classes created by def() only
			return;
		}

		// Where APIs are already bound
		var	anchor = ((jsface.isMap(opts.on) ||  opts.on.classMeta.singleton === true) ? opts.on : opts.on.prototype),
			meta = opts.on.classMeta;

		jsface.each(opts.as, function(fnName, info){
			var	seq = ((info.seq === false) ? false : true),  // default seq is true
				before = (info.before || jsface.emptyFn),	  // no chance for error ;)
				after = (info.after || jsface.emptyFn);	      // no chance for error ;)

			// pointcut on constructo, a little more work
			if (fnName === meta.name){
				// No meaning for singleton constructor
				if (meta.singleton){
					return;
				}

				//  Backup prototype
				var proto = opts.on.prototype;

				// Wrap constructor = constructor + before + after
				meta.parent[meta.name] = wrapper(meta.parent[meta.name], before, after, seq);

				// Restore prototype, no data lost
				meta.parent[meta.name].prototype = proto;
				meta.parent[meta.name].constructor = meta.parent[meta.name];

				// Re-bind static properties, except prototype
				jsface.each(opts.on, function(property, value){
					if (property !== 'prototype'){
						meta.parent[meta.name][property] = value;
					}
				});
			} else { // Normal properties and methods
				anchor[fnName] = wrapper(anchor[fnName], before, after, seq);

				// fnName also is a static function? modify pointer of class signature also
				if (jsface.isFunction(meta.parent[meta.name][fnName])){
					meta.parent[meta.name][fnName] = anchor[fnName];
				}
			}
		});
	};

	/**
	 * def()'s plugin: pointcuts.
	 * Purpose: Support Aspect Oriented Programming in def().
	 * Note: Create an adapter to bind jsface.def.plugins.pointcuts and pointcuts().
	 */
	jsface.def.plugins.pointcuts = function(params){
		var	cls = params.cls,
			bindTo = params.bindTo,
			api = params.api,
			opts = params.opts;

		jsface.pointcuts({
			on: cls,
			as: opts.pointcuts
		});
	};

	/**
	 * Trim a string. If str param is not a string, the whole object will be returned.
	 * @param str string to trim
	 * @param lr left, right flag. true: trim = leftTrim, false: trim = rightTrim, other: both.
	 * @return trimmed string.
	 * @static
	 * @alias jsface.trim
	 */
	jsface.trim =  function(){
		// Code from Ariel Flesler - http://tinyurl.com/yl934kz
		var	chars = ' \n\r\t\v\f\u00a0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000',
			ws = {}, i;
		for (i = 0; i < chars.length; i++){
			ws[chars.charAt(i)] = true;
		}

		return function(str, lr){
			var s = -1, e = str.length;
			while (lr !== true && ws[str.charAt(--e)]){}
			while (lr !== false && s++ !== e && ws[str.charAt(s)]){}
			return str.substring(s, e + 1);
		};
	}();

	/**
	 * Left trim a string.
	 * @param str string to trim
	 * @return trimmed string.
	 * @static
	 * @alias jsface.ltrim
	 */
	jsface.ltrim = function(str){
		return jsface.trim(str, true);
	};

	/**
	 * Right trim a string.
	 * @param str string to trim
	 * @return trimmed string.
	 * @static
	 * @alias jsface.rtrim
	 */
	jsface.rtrim = function(str){
		return jsface.trim(str, false);
	};

	/**
	 * Make a string CamelCase. This function will remove all blank, dash, underscore between words.
	 * @param str input string.
	 * @return Camel Case version of the input string.
	 * @alias jsface.camelcase
	 * @static
	 */
	jsface.camelcase = function(str){
		return str.replace( /(^|\s|-|_)([a-z])/g, function(m, p1, p2){
				return (p1 + p2).toUpperCase();
		}).replace(/(\s|-|_)/g, '');
	};

	/**
	 * Wait until expression function is true then execute the function.
	 * @param {Function} expression a JavaScript expression function.
	 * @param {Function} closure function to be executed when expression is true.
	 * @param {Number} duration waiting duration before next checking, in mili seconds (optional).
	 * @param {Number} timeout timeout, in mili seconds (optional).
	 * @param {Function} onTimeout function to be executed when timeout (optional).
	 */
	jsface.wait = function(expression, closure, duration, timeout, onTimeout){
		// Default duration
		jsface.wait.DURATION = jsface.wait.DURATION ? jsface.wait.DURATION : 250;

		if (expression()){
			closure();
		} else {
			if (jsface.isNumber(timeout) && timeout <= 0){
				if (jsface.isFunction(onTimeout)){
					onTimeout();
				}
			} else {
				duration = jsface.isNumber(duration) ? duration : jsface.wait.DURATION;
				timeout = jsface.isNumber(timeout) ? (timeout - duration) : undefined;

				if (timeout <= 0){
					if (jsface.isFunction(onTimeout)){
						onTimeout();
					}
				} else {
					setTimeout(function(){
						jsface.wait(expression, closure, duration, timeout, onTimeout);
					}, duration);
				}
			}
		}
	};

})();