(function(){
  if (typeof Asteroids === "undefined"){
    window.Asteroids = {};
  }

  GameView = Asteroids.GameView = function(game, ctx){
    this.game = game
    this.ctx = ctx
  };

  GameView.prototype.start = function() {
    var game = this.game
    
    window.setInterval((function(){
      game.step();
      game.draw(this.ctx);
    }).bind(this), 20);
  }
  
})()