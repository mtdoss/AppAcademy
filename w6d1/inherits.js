Function.prototype.inherits = function (superclass) {
  var Surrogate = function() {};
  Surrogate.prototype = superclass.prototype;
  this.prototype = new Surrogate();
};

var Dog = function(name){
  this.name = name; 
};

Dog.prototype.bark = function(){
  console.log(this.name + " says woof woof woof!");
};

var BadDog = function(name){
  this.name = name;
};

BadDog.inherits(Dog);

BadDog.prototype.pissOnFloor = function(){
  console.log(this.name + " goes tssssssss");
};

