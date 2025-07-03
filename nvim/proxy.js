const http = require("http");
const https = require("https");

const API_KEY = process.env.OPENROUTER_API_KEY;
if (!API_KEY) {
  console.error("OPENROUTER_API_KEY not set");
  process.exit(1);
}

http.createServer((req, res) => {
  if (!req.url.startsWith("/v1/")) {
    res.writeHead(404);
    return res.end("Not found");
  }

  let body = [];
  req.on("data", chunk => body.push(chunk));
  req.on("end", () => {
    const requestData = Buffer.concat(body);
    const originalUrl = req.url;
    if (originalUrl.startsWith('/v1/chat/completions')) {
      req.url = originalUrl.replace(/^\/v1/, '/api/v1');
    }
    const options = {
      hostname: "openrouter.ai",
      path: req.url,
      method: req.method,
      headers: {
        "Authorization": `Bearer ${API_KEY}`,
        "Content-Type": "application/json",
        "User-Agent": "avante.nvim",
        "Referer": "http://localhost",
      }
    };

    const proxyReq = https.request(options, proxyRes => {
      res.writeHead(proxyRes.statusCode, {
        ...proxyRes.headers,
        "Content-Type": "text/event-stream", // <<< потрібен для avante
      });

      proxyRes.on("data", chunk => {
        res.write(chunk); // передаємо як є
      });

      proxyRes.on("end", () => res.end());
    });

    proxyReq.on("error", err => {
      res.writeHead(500);
      res.end("Proxy error: " + err.message);
    });

    proxyReq.write(requestData);
    proxyReq.end();
  });
}).listen(3030, () => {
  console.log("✅ SSE Proxy running at http://localhost:3030/v1");
});
