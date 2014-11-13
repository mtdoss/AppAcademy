(function(){
  if(typeof SnakeGame === 'undefined'){
    SnakeGame = {};
  }
  
  var View = SnakeGame.View = function($el) {
    this.board = new SnakeGame.Board();
    this.$el = $el;
    this.handleKeyEvent();
    setInterval(this.step.bind(this), 300);    
  }
  
  View.prototype.handleKeyEvent = function(){
    var that = this;
    $(document).on("keydown", function(event){
      if(event.keyCode === 38){
        that.board.snake.turn('N');
      } else if(event.keyCode === 39){
        that.board.snake.turn('E');
      } else if(event.keyCode === 40){
        that.board.snake.turn('S');
      } else if(event.keyCode === 37){
        that.board.snake.turn('W');
      }
    })
  };
  
  View.prototype.step = function(){
    var nextMove = this.board.snake.add(this.board.snake.dir);
    if (this.board.appleIncludes(nextMove)){
      this.board.eatApple();
      this.board.snake.grow();
    } else{
      this.board.snake.move();
    }
    this.$el.html("<pre>" + this.board.render() + "</pre>");
  }
  
  
})();