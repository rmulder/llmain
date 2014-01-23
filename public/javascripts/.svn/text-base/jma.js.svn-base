

     console.log("begin0");

(function(str){
    console.log(str);
     var children = "child string";
     console.log("begin");
    return {
      addChild: function() { /* add to children array */
        console.log("add child"+ children);
     },
      removeChild: function() { /* remove from children array */
      console.log("remove child");
  }
    }
 })("bbb");
     console.log("begin2");
 //addChild();
// console.log(children);

var a = (function(){
    console.log("other");
    return function(){console.log("inside");};
})()();
//b = a();
//console.log("seperate");
//b();
(function c(){
    console.log("cccc");
})()
//c();