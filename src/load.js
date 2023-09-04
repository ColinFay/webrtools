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

async function loadPackages(webR, dirPath) {
  const files = getDirectoryTree(
    dirPath
  )
  for await (const file of files) {
    if (file.type === 'directory') {
      await globalThis.webR.FS.mkdir(
        `/usr/lib/R/library/${file.path}`,
      );
    } else {
      const data = fs.readFileSync(`webr_packages/${file.path}`);
      await globalThis.webR.FS.writeFile(
        `/usr/lib/R/library/${file.path}`,
        data
      );
    }
  }
}

module.exports = {
  loadPackages: loadPackages
};