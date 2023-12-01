const path = require('path');
const { WebR } = require('webr');
const { Library, loadPackages } = require('../index.js');

const args = process.argv.slice(2);
const webR = new WebR();
const janitor = new Library('janitor');


(async () => {

  await webR.init();

  await loadPackages(
    webR,
    path.join(__dirname, '../webr_packages')
  )

  await janitor.load(webR);
  const res = await janitor.make_clean_names(args);

  console.log(res.values);

  process.exit(1);

})();