const v8 = require('v8');

let arr = [];
let iteration = 0;

try {
  while(true) {
    iteration++;
    arr.push(new Array(1000));
    console.log("iteration", iteration);
    console.log("heap", v8.getHeapStatistics());
  }
} catch(e) {
  console.log(e);
}
