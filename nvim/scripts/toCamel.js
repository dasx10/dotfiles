const readline = require('readline');
const RL = readline.createInterface(process.stdin, process.stdout);

let timer;
const main = () => {
    RL.question("", x => {
        clearTimeout(timer);
        const camilized = x.replace(/[a-z]+(( |_|-)+[a-z0-9]+)+/gmi, (e) => {
            if (e) {
                let [start, ...ends] = e.split(/_|-| /);
                start = start === start.toUpperCase() ? start.toLowerCase() : start.charAt(0) + start.slice(1).toLowerCase()
                return start + ends.map(end => end.charAt(0).toUpperCase() + end.slice(1).toLowerCase()).join('');
            }
            return ""
        });
        console.log(camilized);
        main();
        timer = setTimeout(() => process.exit(0), 0);
    });
}
main();
