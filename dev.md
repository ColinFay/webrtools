```bash
rm -rf $(pwd)/src/webrtools_deps
docker run -it -v $(pwd)/src/webrtools_deps:/root/output ghcr.io/r-wasm/webr R
```

```r
install.packages(c("remotes", "pak"))
dir.create("inputs")
pak::pak("r-wasm/rwasm")
remotes::install_github("colinfay/webrtools", subdir = "r-pkg")
webrtools::download_packs_and_deps("pkgload", "./inputs")
rwasm::file_packager("./inputs", out_dir = ".", out_name = "webrtools_deps")
file.copy("webrtools_deps.data", "/root/output/webrtools_deps.data")
file.copy("webrtools_deps.js.metadata", "/root/output/webrtools_deps.js.metadata")

dir.create("test")
setwd("test")
write.csv(iris, "test/iris.csv")
rwasm::file_packager(".", out_dir = ".", out_name = "iris")
file.copy("iris.data", "/root/output/iris.data")
file.copy("iris.js.metadata", "/root/output/iris.js.metadata")
```