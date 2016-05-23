# grunt-phonegapsplash

[![Available on NPM](https://nodei.co/npm/grunt-phonegapsplash.png?compact=true)](https://npmjs.org/package/grunt-phonegapsplash/)

[![Build Status](https://travis-ci.org/PEM--/grunt-phonegapsplash.png?branch=master)](http://travis-ci.org/PEM--/grunt-phonegapsplash)
[![Dependencies status](https://david-dm.org/PEM--/grunt-phonegapsplash.png)](https://david-dm.org/PEM--/grunt-phonegapsplash)
[![Dev dependencies status](https://david-dm.org/PEM--/grunt-phonegapsplash/dev-status.png)](https://david-dm.org/PEM--/grunt-phonegapsplash/#info=devDependencies)
[![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)

Create [PhoneGap](http://phonegap.com/) splashscreens from a single PNG file.

As of 0.3.X, Cordova / PhoneGap have changed their directory and naming conventions so that it fits better the targeted platforms. This plugin is adapted to the new file structure to ease integration. Check former release  0.1.X if you are still on Cordova / PhoneGap 0.2.X releases.

> **Note on resolutions**: See [App Splash Screen Sizes](https://github.com/phonegap/phonegap/wiki/App-Splash-Screen-Sizes).

![Build flow](https://raw.github.com/PEM--/grunt-phonegapsplash/master/doc/flowchart.png "Build flow")

> In bold, the chart represents the user provided options. Normal texts are the generated sub file paths.

## Basic workflow
0. Design your splashscreen using the highest resolution in Inkscape (2048x2048). _A [canevas](https://raw.github.com/PEM--/grunt-phonegapsplash/master/doc/canevas.svg) is provided under the doc directory._
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
This plugin requires Grunt `>=1.0.0`

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
#### options.prjName
Type: `String`
Default value: `Test`

Specify your project's name. It is mostly used for iOS as the `platforms/ios` sub directory. PhoneGap/Cordova iOS target uses it when building the application.

#### options.layouts
Type: `Array of String`
Default value: `['landscape', 'portrait', 'none']`

Specify the layout mode that you target. The full list is provided as default with the following meanings:

* `landscape`: Splashscreen displayed in landscape mode.
* `portrait`: Splashscreen displayed in portrait mode.
* `none`: Splascreen for squared screens.

#### options.profiles
Type: `Array of String`
Default value: `['android', 'bada', 'blackberry', 'ios', 'webos', 'windows-phone']`

Specify the stores that you target. The full list is provided as default. The default target produce a single `icon.png` at the root of the specified destination directory with the following meanings:

* `android`: Splashcreen for Android phones and tablets.
* `bada`: Splashcreens for Bada and Bada-WAC phones.
* `blackberry`: Splashcreens for Blackberry phones.
* `ios`: Splascreens for iPod touch, iPhone and iPad in normal and retina resolutions.
* `webos`: Splashcreens for WebOS (Palm) phones.
* `windows-phone`: Splashcreens for Windows phones (7 and 8).

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
* 0.5.2: 05/23/2016: iPad & iPad retina resolutions updated: @ashleybrener :clap:
* 0.5.1: 05/23/2016: Grunt 1.0.0 and Cordova iOS4 compatibility: @oshbuckley182 & @vladikoff :clap:
* 0.4.X: 01/16/2015: iPad landscape resolution: @Melmer :clap:
* 0.3.X: 01/09/2015: iPhone6 and iPhone6+ resolutions: @krisrandall :clap:
* 0.2.1: 05/02/2014: Version bump: @PEM--
* 0.2.0: 12/29/2013: Compatibility with PhoneGap/Cordova 0.3.X: @PEM--
* 0.1.1: 12/29/2013: Add 'cordova' as package's keywords: @PEM--
* 0.1.0: 12/28/2013: Initial commit: @PEM--

## Known issue
* N/A.
