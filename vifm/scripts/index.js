(() => {
  var stdout = process.stdout;
  require('readline').createInterface(process.stdin, stdout).question('', (value) =>{
    try {
      return stdout.write(JSON.stringify(JSON.parse(value),null,2));
    } catch (error) {
      return stdout.write(value);
    } finally {
      process.exit(0);
    }
  });
})()
