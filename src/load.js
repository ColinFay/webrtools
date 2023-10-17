const fs = require('fs');
const path = require('path');

// Recursive function to get files, thank you chatGPT
function getDirectoryTree(dirPath, currentPath = '') {
  const items = fs.readdirSync(path.join(dirPath, currentPath));
  const tree = [];

  for (const item of items) {
    const itemPath = path.join(dirPath, currentPath, item);
    const isDirectory = fs.statSync(itemPath).isDirectory();
    const relativePath = path.join(currentPath, item);

    if (isDirectory) {
      const subtree = getDirectoryTree(dirPath, relativePath);
      tree.push({ path: relativePath, type: 'directory' });
      tree.push(...subtree);
    } else {
      tree.push({ path: relativePath, type: 'file' });
    }
  }

  return tree;
}

async function loadFolder(webR, dirPath, outputdir = "/usr/lib/R/library") {
  const files = getDirectoryTree(
    dirPath
  )
  for await (const file of files) {
    if (file.type === 'directory') {
      await globalThis.webR.FS.mkdir(
        `${outputdir}/${file.path}`,
      );
    } else {
      const data = fs.readFileSync(`${dirPath}/${file.path}`);
      await globalThis.webR.FS.writeFile(
        `${outputdir}/${file.path}`,
        data
      );
    }
  }
}

async function loadPackages(webR, dirPath) {
  await loadFolder(webR, dirPath, outputdir = "/usr/lib/R/library");
}

module.exports = {
  loadFolder: loadFolder,
  loadPackages: loadPackages
};