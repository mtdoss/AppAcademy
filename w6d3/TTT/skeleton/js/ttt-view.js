(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    this.$el.on("click", ".square", function(event){
      var $square = $(event.currentTarget);
      that.makeMove($square);
    });
    // this.$el.on("click", ".square", this.makeMove.bind())
    
  };

  View.prototype.makeMove = function ($square) {
    pos = $square.data("pos");
    this.game.playMove(pos);
    if (this.game.currentPlayer === "x"){
      $square.css("background", "blue");    
    }
    else{
      $square.css("background", "red");
    }
    if (this.game.isOver()){
      alert(this.game.winner() + " Wins!");
    }
  };

  View.prototype.setupBoard = function () {
    // for(var i = 0; i < 3; i++){
//       var row = "<div class='row row-num-" + i + "'></div>";
//       this.$el.append(row);
//     }
//     var $row = $('.row');
//     for(var i = 0; i < 3; i++){
//       var square = "<div class='square square-num-" + i + "'></div>";
//       $row.append(square);
//     }
    for(var i = 0; i < 3; i++){
      var $row = $("<div class='row'>");
      this.$el.append($row);
      for(var j = 0; j < 3; j++){
        var $square = $("<div class='square' data-pos='[" + [i, j] + "]'>");
        $row.append($square);
      }
    }
  };
})();
