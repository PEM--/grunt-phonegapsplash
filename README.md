# grunt-phonegapsplash

[![Available on NPM](https://nodei.co/npm/grunt-phonegapsplash.png?compact=true)](https://npmjs.org/package/grunt-phongapsplash/)

[![Build Status](https://secure.travis-ci.org/PEM--/grunt-phongapsplash.png)](http://travis-ci.org/PEM--/grunt-phonegapsplash)
[![Dependencies status](https://david-dm.org/PEM--/grunt-phonegapsplash.png)](https://david-dm.org/PEM--/grunt-phonegapsplash)
[![Dev dependencies status](https://david-dm.org/PEM--/grunt-phonegapsplash/dev-status.png)](https://david-dm.org/PEM--/grunt-phonegapsplash/#info=devDependencies)
[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)

Create [PhoneGap](http://phonegap.com/) splashscreens from a single PNG file.

![Build flow](https://raw.github.com/PEM--/grunt-phonegapsplash/master/doc/flowchart.png "Build flow")

> In bold, the chart represents the user provided options. Normal texts are the generated sub file paths.

## Basic workflow
0. Design your splashscreen using the highest resolution in Inkscape (2008x2008). _A [canevas](https://raw.github.com/PEM--/grunt-phonegapsplash/master/doc/canevas.svg) is provided under the doc directory._
0. Ensure that the splashscreen is visible in portrait and in landscape mode. _The provided canevas has layers that display the portrait and landscape limits for each phones._<br>
![Canevas](https://raw.github.com/PEM--/grunt-phonegapsplash/master/doc/canevas.png "Canevas")
0. Disable the layers that you don't want to see. _Management of layers is accessed via is SHIFT+CTRL+L._
0. Adjust your design so that it fits all screens resolutions (i.e. your design is contained within your chosen gray limits).
0. Export your SVG as a PNG using SHIFT+CTRL+E.
0. Use Grunt and this plugin to produce all your required [PhoneGap](http://phonegap.com/) splashcreens.

## Getting Started
### GraphicsMagick
This plugin requires GraphicsMagick.

If you are on OSX, use HomeBrew:
```
brew install graphicsmagick
```

If you are on Ubuntu:
```
sudo apt-get install graphicsmagick
```

### Grunt
This plugin requires Grunt `~0.4.2`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-phonegapsplash --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-phonegapsplash');
```

## The "phonegapsplash" task
### Overview
In your project's Gruntfile, add a section named `phonegapsplash` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  phonegapsplash: {
    your_target: {
      // Source file: the PNG.
      src: 'app/res/splash.png',
      // Destination directory where are stored all splashscreens
      dest: 'www/',
      // Optionnal, it produces splashscreen and layout for all phonegap targets if not specified
      options: {
        // A list of layouts, it produces landscape and portrait if not specified
        layouts: ['landscape'],
        // A  list of phone targets, it produces android, bada, blackberry, ios, webos, windows-phone if not specified
        profiles: ['windows-phone', 'android']
      }
    },
  },
});
```

### Options
#### options.layouts
Type: `Array of String`
Default value: `['landscape', 'portrait']`

Specify the layout mode that you target. The full list is provided as default.

#### options.profiles
Type: `Array of String`
Default value: `['android', 'bada', 'blackberry', 'ios', 'webos', 'windows-phone']`

Specify the stores that you target. The full list is provided as default. The default target produce a single `icon.png` at the root of the specified destination directory.

> **NOTE**<br>If an unused target is provided, nothing happens. This favors the re-use of already defined targeted OSes (stores or platforms) as find under the [grunt-svg2storeicons](https://npmjs.org/package/grunt-svg2storeicons).

### Usage Examples
#### Default Options
In this example, the default options are used. All splashcreens for all layout and all OSes are being produced. The `src` contains the filepath to the original PNG splashscreen. The `dest` contains the directory in which the splashscreens are produced.
```js
grunt.initConfig({
  phonegapsplash: {
    all_phones: {
      src: 'app/res/splash.png',
      dest: 'www/'
    }
  }
});
```

#### Custom Options
In this example, custom options are used to create the unique splashscreen for blackberry.
```js
grunt.initConfig({
  svg2storeicons: {
    blackberry_only: {
      src: 'app/res/splash.png',
      dest: 'www/',
      options: {
        layouts: ['landscape']
        profiles: ['blackberry']
      }
    }
  }
});
```

## Contributing
The main plugin is written and its tests are written in CoffeeScript. In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/). Feel free to contribute.

## Release History
* 0.1.0: 12/28/2013: Initial commit: [PEM--]( https://github.com/PEM-- )

## Known issue
* N/A.
