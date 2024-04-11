var readline = require('readline');
var { stdin, stdout, exit } = process;
var RL = readline.createInterface(stdin, stdout);

var timer;
void function main() {
  return RL.question("", (value) => {
    clearTimeout(timer);
    if (value) {
      try {
        process.stdout.write(value.replace(/[\d\(][\d\. \s\+\-\/\*\(\)]+/g, (value) => {
          try {
            return eval(value)
          } catch (_) {
            return value;
          }
        }));
        main();
      } catch (error) {
        process.stdout.write(value.replace(/([\d]+|[\d]+\.[\d]+)(| |\s)+(\+|\-|\/|\*|\*\*)(| |\s)+([\d]+|[\d]+\.[\d]+)/g, (value) => eval(value)));
        main();
      }
      timer = setTimeout(exit, 0, 0);
    }
  });
}();
