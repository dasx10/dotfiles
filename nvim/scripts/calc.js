
const readline = require('readline');
const RL = readline.createInterface(process.stdin, process.stdout);

let timer;
const main = () => {
    RL.question("", x => {
        clearTimeout(timer);
        try {
          const result = x.replace(/[0-9\(][0-9\. \s\+\-\/\*\(\)]+/g, (e) => {
            try {
              return eval(e)
            } catch (_) {
              return e;
            }
          });
          console.log(result);
          main();
        } catch (error) {
          const result = x.replace(/([0-9]+|[0-9]+\.[0-9]+)(| |\s)+(\+|\-|\/|\*|\*\*)(| |\s)+([0-9]+|[0-9]+\.[0-9]+)/g, (e) => eval(e));
          console.log(result);
          main();
        }
        timer = setTimeout(() => process.exit(0), 0);
    });
}
main();

