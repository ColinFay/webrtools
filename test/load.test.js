// test the load function with jest

const { loadPackages } = require('../src/load');
const path = require('path');
const fs = require('fs');
const {WebR} = require("webr")
const webR = new WebR();

test('A package can be loaded from default lib', async () => {

  await webR.init();

  if (fs.existsSync(
    path.join(__dirname, '../webr_packages')
  )){
    await loadPackages(
      webR,
      path.join(__dirname, '../webr_packages')
    )

    const res = await webR.evalR("dplyr::starwars");
    const as_js = await res.toJs();

    expect(as_js.type).toBe('list');
  }

});

