require('readline').createInterface(process.stdin, process.stdout).question('',x=>{
  try {
    return console.log(JSON.stringify(JSON.parse(x),null,2));
  } catch (error) {
    return console.log(x);
  } finally {
    process.exit(0);
  }
});
