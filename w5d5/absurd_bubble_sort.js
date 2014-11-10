var readline = require('readline');
var reader = readline.createInterface({
  // it's okay if this part is magic; it just says that we want to
  // 1. output the prompt to the standard output (console)
  // 2. read input from the standard input (again, console)

  input: process.stdin,
  output: process.stdout
});

var askIfLessThan = function(el1, el2, callback) {
  console.log("el1 is: " + el1);
  console.log("el2 is: " + el2);
  reader.question("Is el1 less than el2: ", function (yesNo) {
    var answer = yesNo;

    if (answer === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if(i < (arr.length - 1)) {
    askIfLessThan(arr[i], arr[i+1], function(isLessThan){
      if (!isLessThan) {
        var temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        madeAnySwaps = true;
      }
      else{
        madeAnySwaps = false; //maybe
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    }); }
    else if (i === (arr.length - 1)){
      outerBubbleSortLoop(madeAnySwaps);
    }
};


function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if (madeAnySwaps){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}


absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});