
const fs = require('fs');
const { WebR } = require('webr');
const webR = new WebR();

(async () => {

  await webR.init();

  const data = new Blob(
    fs.readFileSync(
      "/Users/colinfay/git/github/colinfay/webrtools/src/webrtools_deps/iris.data"
    )
  );

  console.log(data)

  const metadata = JSON.parse(
    fs.readFileSync(
      "/Users/colinfay/git/github/colinfay/webrtools/src/webrtools_deps/iris.js.metadata"
    )
  );

  console.log(metadata)

  await webR.FS.mkdir('/data');

  const options = {
    packages: [{
      blob: new Blob([data]),
      metadata: metadata,
    }],
  }
  await webR.FS.mount("WORKERFS", options, '/data');

  process.exit(1);

})();