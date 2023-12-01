
class Library {
  constructor(lib) {
    this.lib = lib;
    this.namespace = [];
  }
  async load(webR) {

    this.namespace = await webR.evalRRaw(
      `getNamespaceExports("${this.lib}")`,
      'string[]'
    );

    for (const fun of this.namespace) {
      this[fun] = await webR.evalR(
        `getExportedValue("${this.lib}","${fun}")`
      );
    }
  }
}

class LibraryFromLocalFolder extends Library{

  async mountAndLoad(webR, localDir) {
    const libraryPath = `/home/${this.lib}`;

    await webR.FS.mkdir(libraryPath);

    await webR.FS.mount(
      "NODEFS",
      {
        root: localDir
      },
      libraryPath
    )

    // see https://github.com/r-wasm/webr/issues/292
    await webR.evalR("options(expressions=1000)")
    await webR.evalR(`pkgload::load_all('/home/${this.lib}')`);
    await this.load(webR);
  }

}

exports.LibraryFromLocalFolder = LibraryFromLocalFolder;
exports.Library = Library;