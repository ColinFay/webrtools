# webrtools

Random tools to work with `webr`

## Install

```bash
npm i webrtools
```

## Pre-install and load R packages

```bash
# In your terminal
Rscript ./node_modules/webrtools/r/install.R dplyr

# In your app
const { loadPackages } = require('webrtools');
const { WebR } = require('webr');

(async () => {
  globalThis.webR = new WebR();
  await globalThis.webR.init();

  await loadPackages(
    globalThis.webR,
    path.join(__dirname, 'webr_packages')
  )

  await globalThis.webR.evalR("library(dplyr)");
})();
```

