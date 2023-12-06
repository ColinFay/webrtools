// test the load function with jest

const { Library, LibraryFromLocalFolder } = require('../src/library');
const { WebR } = require("webr")
const webR = new WebR();

test('A Library can be created from a base package', async () => {

  await webR.init();

  const tools = new Library(
    'tools'
  )

  await tools.load(
    webR
  )

  const res = await tools.toTitleCase("hello world");

  expect(res.values[0]).toBe('Hello World');

});

test('A Library can be created from a custom package', async () => {

  await webR.init();

  const testpkg = new LibraryFromLocalFolder(
    'testpkg'
  )

  await testpkg.mountAndLoad(
    webR,
    __dirname + '/testpkg'
  )

  console.log(testpkg)
  expect(res.values[0]).toBe('Hello World');

});

