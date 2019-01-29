const path = require('path');

const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './src/main.js',
  optimization: {
    minimize: true
  },
  output: {
    path: path.join(process.cwd(), 'dist', 'www')
  },
  plugins: [
    new CleanWebpackPlugin([`${__dirname}/www`, `${__dirname}/dist`], {
      root: `${__dirname}`,
      exclude: [],
      verbose: true,
      dry: false
    }),
    // new webpack.optimize.UglifyJsPlugin(),
    new HtmlWebpackPlugin({
      template: `${__dirname}/public/index.html`
    })
  ],
  module: {
    rules: [{
      test: /\.(html)$/,
      use: {
        loader: 'html-loader',
        options: {
          attrs: [':data-src'],
          minimize: true
        }
      }
    }, {
      test: /\.(js|jsx)$/,
      loader: 'babel-loader'
    }]
  }
}