(function() {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }
  
  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.render();
    this.click1 = "unset";
    this.clickTower();
  }
  
  View.prototype.render = function() { 
    this.$el.empty();
    for(var i = 0; i < 3; i++){
      var $stack = $("<div class='stack' data-stacknum='" + i + "'>");
      var $disks = $("<div class='disks'>");
      $stack.append($disks)
      this.$el.append($stack);
      
      // this.game.towers[i].forEach(function(el, j){
//         var $disk = $("<div class='disk' data-disknum='" + el + "'>");
//         $stack.append($disk);
//         $disk.addClass("disk-" + el);
//       });
        for(var j = 3; j >= 0; j--){
          var that = this;
          var $disk = $("<div class='disk' data-disknum='" + that.game.towers[i][j] + "'>");
          $disks.append($disk);
          $disk.addClass("disk-" + that.game.towers[i][j]);
        };
    }
  }
  
  View.prototype.clickTower = function() {
    var that = this;
    this.$el.on("click", ".stack", function(event){
      var $stack = $(event.currentTarget);
      if (that.click1 !== "unset"){
        var click2 = $stack.data("stacknum");
        if(that.game.isValidMove(that.click1, click2)){
          that.game.move(that.click1, click2);
          that.click1 = "unset";
          that.render();
        } else {
          alert("invalid move, dummy!");
          that.click1 = "unset";
        }
      }else{
        that.click1 = $stack.data("stacknum");
      }
      if(that.game.isWon()){
        alert("You win, dummy!")
        that.click1 = "unset";
      }
      
    })
  }
  
})();