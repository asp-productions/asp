## SRC folder for ASP site

## Tools

### Yarn

[Yarn](https://yarnpkg.com) is used for package managment (instead of NPM) because it's fast and generates a lock file to make dependency management more consistent. The theme's `.gitignore` file should be kept intact to make sure that all files in the `node_modules` folder are not pushed to the repository.

### Webpack

If you want to use an external script, just add it via Yarn, and reference it in main.js. You'll find instructions in the js/main.js file.

### PostCSS
PostCSS is just CSS. You'll find `postcss.config.js` in the css folder. There you'll find that we're using [`postcss-import`](https://github.com/postcss/postcss-import) which allows us import css files directly from the node_modules folder, [`postcss-cssnext`](http://cssnext.io/features/) which gives us the power to use upcoming CSS features today. If you miss Sass you can find PostCss modules for those capabilities, too.


### Tachyons

This site uses the [Tachyons CSS Library](http://tachyons.io/). It's about 15kb gzipped, highly modular, and each class is atomic so you never have to worry about overwriting your styles. It's a great library for themes because you can make most all the style changes you need right in your layouts.

## How to Use

You'll find the commands to run in `src/package.json`.