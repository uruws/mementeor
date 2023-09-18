import { Meteor } from 'meteor/meteor';
const v8 = require('v8');

Meteor.startup(() => {
  // code to run on server at startup
});
let arr = [];
let iteration = 0;
Meteor.methods({
  'generateGarbage'() {
    try{
     while(true) {
       iteration++;
       arr.push(new Array(1000));
       console.log("iteration", iteration);
       console.log("heap", v8.getHeapStatistics());
     }
    }catch(e){
      console.log(e);
    }
   }
});

