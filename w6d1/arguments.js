// var sum = function() {
//   args = Array.prototype.slice.call(arguments);
//   result = 0;
//   args.forEach(function(arg) {
//     result += arg;
//   });
//   return result;
// };

// var myBind = function(context) {
//   var args = arguments;
//   var fn = this;
//   return function(){
//     fn.apply(context, args);
//   };
// };

var curriedSum = function (numArgs) {
  var numbers = [];
  
  var _curriedSum = function (num) {
    numbers.push(num);
    
    if (numbers.length === numArgs){
      result = 0;
      numbers.forEach(function(arg) {
        result += arg;
      });
      
      return result;
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};

//
//
// var sum = curriedSum(4);
// console.log(sum(5)(30)(20)(1));

Function.prototype.curry = function(numArgs){
  var args = [];
  var that = this;
  var _curried = function(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      that.apply(args);
    } else {
      return _curried;
    }
  };     
  return _curried; 
};
