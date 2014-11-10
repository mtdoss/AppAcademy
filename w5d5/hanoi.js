var readline = require('readline');
var reader = readline.createInterface({
  // it's okay if this part is magic; it just says that we want to
  // 1. output the prompt to the standard output (console)
  // 2. read input from the standard input (again, console)

  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function(){
  //big number = big sphere, on bottom
  this.stacks = [ [3, 2, 1], [], [] ];
};

HanoiGame.prototype.isWon = function(){
  return (this.stacks[1].length === 3 || this.stacks[2].length === 3);
  // console.log(stacks[1])
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx){
  var from = this.stacks[startTowerIdx];
  var to = this.stacks[endTowerIdx];
  if (from.length === 0){
    return false;
  }

  if ((from[from.length-1] < to[to.length-1]) || to.length === 0){
    return true;
  }else{
    return false;
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx){
  if (!this.isValidMove(startTowerIdx, endTowerIdx)){
    return false;
  }
  var from = this.stacks[startTowerIdx];
  var to = this.stacks[endTowerIdx];
  to.push(from.pop());
  console.log(this.stacks);
  return true;
};

HanoiGame.prototype.promptMove = function(callback) {
  console.log("Disks on the zero tower are: " + this.stacks[0]);
  console.log("Disks on the one tower are: " + this.stacks[1]);
  console.log("Disks on the two tower are: " + this.stacks[2]);

  reader.question("What tower should we take the disk from? ",
      function (fromTower) {
        reader.question("What tower should we move the disk to",
        function (toTower){
          var from = parseInt(fromTower, 10);
          var to = parseInt(toTower, 10);

          callback(from, to);
        });
   });
};

HanoiGame.prototype.run = function(completionCallback){
  this.promptMove(function(startTowerIdx, endTowerIdx) {
    if(!this.move(startTowerIdx, endTowerIdx)) {
      console.log("Invalid move");
    }
    if (!this.isWon()){
      this.run(completionCallback);
    } else{
      console.log("You won!");
      completionCallback();
    }
  }.bind(this));

};



var tower = new HanoiGame();
tower.run(reader.close.bind(reader));
// console.log(tower.isWon());
// console.log(tower.isValidMo ve(1, 0));
// console.log(tower.move(1, 0));
// console.log(tower.move(0, 1));
// console.log(tower.move(0, 1));