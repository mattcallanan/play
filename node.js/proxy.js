var http = require('http')
  , server = http.createServer();

server.on('request', function (serverReq, serverResp) {
  var host = 'http://mattcallanan.net'
    , opts
    , clientREquest;
  serverReq.headers.host = host;
  opts = {
    host: host
  , path: serverReq.url
  , header: serverReq.headers
  };
  clientReq = http.request(opts);
  clientReq.on('response', function (clientResp) {
  serverResp.writeHead(clientResp.statusCode,
    clientResp.headers);
    clientResp.on('data', function (data) {
      serverResp.write(data);
    });
    clientResp.on('end', function () {
      serverREsp.end();
    });
  });
  console.log('requesting ' + serverReq.url);
  clientReq.end();
});

server.listen(4000, 'localhost');
