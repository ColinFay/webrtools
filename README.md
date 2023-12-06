# webrtools

Random tools to work with `webr`

## Install

```bash
npm i webrtools
```

## Command line tools

- Download a webR compiled package and its dependencies:

```bash
Rscript ./node_modules/webrtools/r/install.R dplyr
```

- Read a DESCRIPTION file and build the webR package library

```bash
# In your terminal
Rscript ./node_modules/webrtools/r/install_from_desc.R $(pwd)/rfuns/DESCRIPTION
```


## Load a webR library (built with the previous command)


```javascript
const { loadPackages } = require('webrtools');
const { WebR } = require('webr');
const webR = new WebR();

(async () => {

  await webR.init();

  await loadPackages(
    webR,
    path.join(__dirname, 'webr_packages')
  )

  await globalThis.webR.evalR("library(dplyr)");
})();
```

## Load a local R package (contained in a folder) and call it from webr

```javascript
const { loadPackages } = require('webrtools');
const { WebR } = require('webr');
const webR = new WebR();

(async () => {

  await webR.init();

  await loadPackages(
    webR,
    path.join(__dirname, 'webr_packages')
  )

  await globalThis.webR.FS.mkdir("/home/rfuns")

  await globalThis.webR.FS.mount(
    "NODEFS",
    {
      root: path.join(__dirname, 'rfuns')
    },
    "/home/rfuns"
  )

  await globalThis.webR.evalR("options(expressions=1000)")
  await globalThis.webR.evalR("pkgload::load_all('/home/rfuns')");
})();
```

## Examples

Git clone this project, then:

### Passing args to janitor::make_clean_names()

```
Rscript ./r/install.R janitor
node examples/janitor.js "Hello world"
node examples/janitor.js "This is another test"
```

