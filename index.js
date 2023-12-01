const load = require('./src/load.js')
const library = require('./src/library.js')

exports.loadPackages = load.loadPackages;
exports.loadFolder = load.loadFolder;

exports.LibraryFromLocalFolder = library.LibraryFromLocalFolder
exports.Library = library.Library