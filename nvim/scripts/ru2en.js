const readline = require('readline');
const rus = "йцукенгшщзфывапролдячсмить";
let eng = "qwertyuiopasdfghjklzxcvbnm";
eng = eng + eng.toUpperCase();
const RL  = readline.createInterface(process.stdin, process.stdout);
const keys = new Map(Array.from(rus + rus.toUpperCase(), (ruChar, index) => [ruChar, eng[index]]));
let timer;
void function run () {
  RL.question('',x=>{
    clearTimeout(timer);
    console.log(Array.from(x,c=>keys.get(c)||c).join(''));
    run();
    timer = setTimeout(() => process.exit(0), 0);
  });
}()
