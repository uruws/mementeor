import { Meteor } from 'meteor/meteor';
const v8 = require('v8');

Meteor.startup(() => {
  console.log('loaded!')
});

let arr = [];
let iteration = 0;

Meteor.methods({
  'generateGarbage'() {
    console.log('generate garbage...');
    try {
      while(true) {
        iteration++;
        arr.push(new Array(1000));
        console.log("iteration", iteration);
        console.log("heap", v8.getHeapStatistics());
      }
    } catch(e) {
        console.log("heap", v8.getHeapStatistics());
        console.log(e);
    }
  }
});
