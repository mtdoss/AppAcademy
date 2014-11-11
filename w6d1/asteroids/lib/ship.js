(function() {
	if (typeof Asteroids === "undefined"){
		window.Asteroids = {};
	}
var Util = Asteroids.Util;

var Ship = Asteroids.Ship = function(pos, game){
	this.vel = [0, 0];
	this.radius = 10;
	this.color = "blue";
	this.pos = pos
	this.game = game
}

Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

})();