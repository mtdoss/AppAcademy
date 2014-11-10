var readline = require('readline');
var reader = readline.createInterface({
  // it's okay if this part is magic; it just says that we want to
  // 1. output the prompt to the standard output (console)
  // 2. read input from the standard input (again, console)

  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, completionCallback){
  // var sum = 0;
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function (numString1) {
      var num = parseInt(numString1);
      console.log(num);
      sum += num;
      console.log(sum);

      addNumbers(sum, numsLeft - 1, completionCallback);

    })
  } else {
    completionCallback(sum);
    return sum;

    }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
  reader.close();
});