const http = require('http');
const { exec } = require('child_process');

http.createServer((req, res) => {
  if (req.url === '/build') {
    console.log('Triggering build...');
    const cmd = 'git pull && ./gradlew assembleDebug && git add . && (git commit -m "Automated build" || echo "Nothing to commit") && git push';
    exec(cmd, (err, stdout, stderr) => {
      res.writeHead(err ? 500 : 200, { 'Content-Type': 'text/plain' });
      res.end(err ? `Error:
${stderr}` : `Success:
${stdout}`);
    });
  } else {
    res.writeHead(404).end('Not Found');
  }
}).listen(8182, () => console.log('Build Server running on port 8182'));
