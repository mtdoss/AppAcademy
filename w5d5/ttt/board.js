var Board = function() {
  this.grid = new Array( new Array(3), new Array(3), new Array(3) );
};

Board.prototype.won = function() {
  var didWin = false;
  this.grid.forEach(function(row) {

      if (row.join() === "x,x,x" || row.join() === "o,o,o"){
         didWin =  true;
    }
  });

  var dup = transpose(this.grid);
  dup.forEach(function(row) {
      if (row.join() === "x,x,x" || row.join() === "o,o,o"){
         didWin =  true;
    }
  });

  if (dup[0][0] === dup[1][1] &&
      dup[2][2] === dup[1][1] && (dup[0][0] === 'x' || dup[0][0] === 'o')) {
         didWin =  true;
      }

  if (dup[0][2] === dup[1][1] &&
      dup[2][0] === dup[1][1] && (dup[0][2] === 'x' || dup[0][2] === 'o')) {
         didWin =  true;
      }

  if (didWin) {
    return true;
  } else {
    return false;
  }
};

//pos looks like [0, 0]
Board.prototype.empty = function(pos){
  var p = this.grid[pos[0]][pos[1]];
  if (p === "x" || p === "o"){
    return false;
  }
  else{
    return true;
  }
};

Board.prototype.placeMark = function(pos, mark){
  this.grid[pos[0]][pos[1]] = mark;
};

var transpose = function(arr) {
  var dup = new Array( new Array(3), new Array(3), new Array(3) );
  for (var i = 0; i < 3; i++ ) {
    for (var j = 0; j < 3; j++) {
      dup[i][j] = arr[j][i];
    }
  }
  return dup;
};

module.exports = Board;