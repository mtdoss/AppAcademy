(function(){
  if(typeof SnakeGame === 'undefined'){
    SnakeGame = {};
  }
  
  var Board = SnakeGame.Board = function(){
    this.snake = new SnakeGame.Snake();
    this.apples = [];
    this.addApple();
    this.grid = [];
    this.buildGrid(10);
  };
  
  Board.prototype.buildGrid = function(size) {
    var that = this;
    for(var i = 0; i < size; i++){
      that.grid.push([]);
      for(var j = 0; j < size; j++){
        that.grid[i].push([]);
      }
    }
  }
  
  Board.prototype.render = function() {
    var that = this;
    this.grid.forEach(function(row, i){
      row.forEach(function(el, j){
        if(that.snake.includes([i,j])){
          that.grid[i][j] = 'S';
        } else if(that.appleIncludes([i, j])){
          that.grid[i][j] = 'A';
        } else {
          that.grid[i][j] = '.';
        }
      })
    })
    var str = "";
    this.grid.forEach(function(row){
      row.forEach(function(el){
        str += el;
      })
      str += '\n';
    });
    return str;
  }
  
  
  Board.prototype.addApple = function(){
    var x = Math.floor(Math.random() * 10);
    var y = Math.floor(Math.random() * 10);
    if (this.snake.includes([x, y])){
      this.addApple();
    } else{
      this.apples.push([x, y]);
    }
  }
  
  Board.prototype.eatApple = function() {
    this.apples.pop();
    this.addApple();
  }
  
  //TODO: Refactor
  Board.prototype.appleIncludes = function(pos){
    var len = this.apples.length;
    var bool = false;
    for (var i = 0; i < len; i++){
      if (this.apples[i][0] === pos[0] && this.apples[i][1] === pos[1]){
        bool = true;
      }
    }
    return bool;
  }
  
})();