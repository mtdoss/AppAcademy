var Board = require("./board");

var Game = function(reader){
  this.reader = reader;
  this.board = new Board();
  this.mark = "o";
};

Game.prototype.promptMove = function(callback) {
  console.log("Row 0: " + this.board.grid[0]);
  console.log("Row 1: " + this.board.grid[1]);
  console.log("Row 2: " + this.board.grid[2]);

  this.reader.question("What x coordinate? ",
      function (xCoord) {
        reader.question("What y coordinate? ",
        function (yCoord){

          callback(xCoord, yCoord);
        });
   });
};

Game.prototype.run = function(completionCallback){
  this.mark = this.mark === "x" ? "o" : "x";

  this.promptMove(function(xCoord, yCoord) {
    if(!this.board.empty([xCoord, yCoord])) {
      console.log("Invalid Move");
    }
    else {
      this.board.placeMark([xCoord, yCoord], this.mark);
    }


    if(!this.board.won()){
      this.run(completionCallback);
    } else {
      console.log("You won!");
      completionCallback();
    }
  }.bind(this));
};

module.exports = Game;