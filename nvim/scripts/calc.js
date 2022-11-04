const readline = require('readline');
const { stdin, stdout, exit } = process;
const RL = readline.createInterface(stdin, stdout);

let timer;
const empty = "";
void function main() {
  return RL.question(empty, x => {
    clearTimeout(timer);
    if (x) {
      try {
        console.log(x.replace(/[0-9\(][0-9\. \s\+\-\/\*\(\)]+/g, (e) => {
          try {
            return eval(e)
          } catch (_) {
            return e;
          }
        }));
        main();
      } catch (error) {
        console.log(x.replace(/([0-9]+|[0-9]+\.[0-9]+)(| |\s)+(\+|\-|\/|\*|\*\*)(| |\s)+([0-9]+|[0-9]+\.[0-9]+)/g, (e) => eval(e)));
        main();
      }
      timer = setTimeout(exit, 0, 0);
    }
  });
}();
