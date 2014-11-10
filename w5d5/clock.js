function Clock () {
}

Clock.TICK = 500;

// fn.bind(context)
//
// fn.apply(context, [arguments])
// fn.call(context, arg, arg, arg)

Function.prototype.myBind = function(context) {
  var fn = this;
  return function() {
    fn.apply(context);
  };
};

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var seconds = this.currentTime.getSeconds();
  var hours = this.currentTime.getHours();
  var minutes = this.currentTime.getMinutes();

  var str = hours + ":" + minutes + ":" + seconds;
  console.log(str);
};

// myClock = new Clock();
//
// console.log(myClock.printTime());

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.currentTime = new Date();
  setInterval(this._tick.myBind(this), Clock.TICK);
  // this.printTime();
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  // this.currentTime += Clock.TICK
  this.printTime();
  this.currentTime.setTime(this.currentTime.getTime() + Clock.TICK);
};

clock = new Clock();
clock.run();




