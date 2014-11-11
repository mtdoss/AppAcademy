(function() {
  if (typeof Asteroids === "undefined"){
    window.Asteroids = {};
  }
  

  var Game = Asteroids.Game = function(){
    
    this.DIM_X = 800;
    this.DIM_Y = 600;
    this.NUM_ASTEROIDS = 20;
    this.asteroids = [];
    this.addAsteroids();
    this.ships = []
    this.buildShip();
    // this.ship = new Asteroids.Ship(Game.randomPosition());
  };
  
  Game.prototype.addAsteroids = function(){
    for (var i = 0; i < this.NUM_ASTEROIDS; i++){
      this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(), this));
    }
  };
  
  Game.prototype.randomPosition = function(){
    var posx = Math.floor(Math.random() * this.DIM_X);
    var posy = Math.floor(Math.random() * this.DIM_Y);
    return [posx, posy];
  };
  
  Game.prototype.draw = function(ctx){
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    ctx.fillStyle = 'black'
    ctx.fillRect(0, 0, this.DIM_X, this.DIM_Y);
    
    this.allObjects().forEach(function(object){
      object.draw(ctx);
    });
  };
  
  Game.prototype.moveObjects = function(){
    this.allObjects().forEach(function(object){
      object.move();
    });
  };
  
  Game.prototype.wrap = function(pos) {
    var x = pos[0];
    var y = pos[1];
    if (x <= 0) {
      x = x + this.DIM_X;
    } else if (x >= this.DIM_X) {
      x = 0;
    }
    if (y <= 0) {
      y = y + this.DIM_Y;
    } else if (y >= this.DIM_Y) {
      y = 0
    }
    return [x, y]
  }
  
  
  Game.prototype.checkCollisions = function(){
    var that = this;
    for (var i = 0; i < this.asteroids.length; i++){
      for (var j = i + 1; j < this.asteroids.length; j++){
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])){
          this.allObjects().splice(i, 1);
          this.allObjects().splice(j - 1, 1);
        }
      }
    }
  }
  
  Game.prototype.step = function(){
    this.moveObjects();
    this.checkCollisions();
  }
  
  
  Game.prototype.allObjects = function(){
    return [].concat(this.asteroids).concat(this.ships);
  }

  Game.prototype.buildShip = function(){
    pos = this.randomPosition();
    var ship = new Asteroids.Ship(pos, this);

    this.ships.push(ship);
  }
  

})();






















