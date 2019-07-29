/*** 
 * Webpack config file for compiling and managing site assets.
 */

const path = require('path');
const AssetsPlugin = require('assets-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const devMode = process.env.NODE_ENV !== 'production';

module.exports = {
	entry: {
		app: './js/main.js',
	},
	output: {
		path: path.resolve(__dirname, './../static/dist'),
		filename: 'js/[name].[chunkhash].js',
		libraryTarget: 'umd',
		library: 'asp'
	},
	mode : devMode ? 'development' : 'production',
	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: /node_modules/,
				use: {
					loader: 'babel-loader',
					options: {
						presets: ['env']
					}
				}
			},
			{
				test: /\.css$/,
				exclude: /node_modules/,
				use: [
					'style-loader',
					MiniCssExtractPlugin.loader,
					{ loader: 'css-loader', options: { importLoaders: 1 } },
					'postcss-loader',
				]
			}
		]
	},
	optimization: {
		splitChunks: {
		  cacheGroups: {
			styles: {
			  name: 'app',
			  test: /\.css$/,
			  chunks: 'all',
			  enforce: true,
			},
		  },
		},
	  },
	plugins: [
		new AssetsPlugin({
			path: path.resolve(__dirname, '../data'),
			filename: 'webpack_assets.json',
			prettyPrint: devMode ? true : false
		}),
		new MiniCssExtractPlugin({
			filename: devMode ? 'css/[name].[hash].css' : 'css/[name].[hash].css',
		})
	],
	resolve: {
		modules: [path.resolve(__dirname, 'src'), 'node_modules']
	},
};
