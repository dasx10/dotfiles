var readline = require('readline');
var RL       = readline.createInterface(process.stdin, process.stdout);
var keys = JSON.parse('{"й":"q","ц":"w","у":"e","к":"r","е":"t","н":"y","г":"u","ш":"i","щ":"o","з":"p","ф":"a","ы":"s","в":"d","а":"f","п":"g","р":"h","о":"j","л":"k","д":"l","я":"z","ч":"x","с":"c","м":"v","и":"b","т":"n","ь":"m","Й":"Q","Ц":"W","У":"E","К":"R","Е":"T","Н":"Y","Г":"U","Ш":"I","Щ":"O","З":"P","Ф":"A","Ы":"S","В":"D","А":"F","П":"G","Р":"H","О":"J","Л":"K","Д":"L","Я":"Z","Ч":"X","С":"C","М":"V","И":"B","Т":"N","Ь":"M"}');

var timer;
void function run () {
  RL.question('', (value) =>{
    clearTimeout(timer);
    process.stdout.write(Array.from(value, (key) => keys[key] || key).join(''));
    run();
    timer = setTimeout(() => process.exit(0), 0);
  });
}()
