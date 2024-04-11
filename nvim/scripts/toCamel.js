var readline = require('readline');
var RL = readline.createInterface(process.stdin, process.stdout);

let timer;
var main = () => {
  RL.question("", (value) => {
    clearTimeout(timer);

    var create = value.replace(/[a-z]+(( |_|-)+[a-z0-9]+)+/gmi, (value) => {
      if (value) {
        var next = value.split(/_|-| /);
        var is = next.shift();
        is = is === is.toUpperCase() ? is.toLowerCase() : is.charAt(0) + is.slice(1).toLowerCase()
        return is + next.map((done) => done.charAt(0).toUpperCase() + done.slice(1).toLowerCase()).join('');
      }
      return ""
    });

    process.stdout.write(create);

    main();

    timer = setTimeout(() => process.exit(0), 0);
  });
}
main();
