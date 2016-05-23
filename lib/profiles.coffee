###
# grunt-phonegapsplash
# https://github.com/PEM--/grunt-phonegapsplash
#
# Copyright (c) 2013 Pierre-Eric Marchandet (PEM-- <pemarchandet@gmail.com>)
# Licensed under the MIT licence.
###

'use strict'

# Path from NodeJS app is used to merge directory and sub drectories.
path = require 'path'

###
# All profiles for every splashscreens covered by PhoneGap are stored hereafter
#  with the following structure:
#
#  * platform: A dictionary key representing the OS (the platform)
#    * dir: The subfolder where are stored the splashscreens
#    * layout: A dictionary key representing the available layouts
#      * splashs: An array of the required splashscreens
#        * name: The name of the splashscreen
#        * width: The width of the splashscreen
#        * height: The height of the splascreen
###
module.exports = (config) ->
  # Android
  'android':
    dir: path.join 'platforms', 'android', 'res'
    layout:
      landscape:
        splashs: [
          {
            name: (path.join 'drawable-land-ldpi', 'screen.png')
            width: 320, height: 200
          }
          {
            name: (path.join 'drawable-land-mdpi', 'screen.png')
            width: 480, height: 320
          }
          {
            name: (path.join 'drawable-land-hdpi', 'screen.png')
            width: 800, height: 480
          }
          {
            name: (path.join 'drawable-land-xhdpi', 'screen.png')
            width: 1280, height: 720
          }
        ]
      portrait:
        splashs: [
          {
            name: (path.join 'drawable-port-ldpi', 'screen.png')
            width: 200, height: 320
          }
          {
            name: (path.join 'drawable-port-mdpi', 'screen.png')
            width: 320, height: 480
          }
          {
            name: (path.join 'drawable-port-hdpi', 'screen.png')
            width: 480, height: 800
          }
          {
            name: (path.join 'drawable-port-xhdpi', 'screen.png')
            width: 720, height: 1280
          }
        ]
  # Bada and Bada WAC
  'bada':
    dir: path.join 'res', 'screen', 'bada'
    layout:
      portrait:
        splashs: [
          { name: 'screen-type5.png', width: 240, height: 400 }
          { name: 'screen-type3.png', width: 320, height: 480 }
          { name: 'screen-type4.png', width: 480, height: 800 }
          { name: 'screen-portrait.png', width: 480, height: 800 }
        ]
  # Blackberry
  'blackberry':
    dir: path.join 'res', 'screen', 'blackberry'
    layout:
      none:
        splashs: [
          { name: 'screen-225.png', width: 225, height: 225 }
        ]
  # iOS (Retina and legacy resolutions)
  'ios':
    dir: if config.useXCAssetsPath
      path.join 'platforms', 'ios', config.prjName, 'Images.xcassets', 'LaunchImage.launchimage'
    else
      path.join 'platforms', 'ios', config.prjName, 'Resources', 'splash'
    layout:
      landscape:
        splashs: [
          { name: 'Default-Landscape~ipad.png', width: 1024, height: 768 }
          { name: 'Default-Landscape@2x~ipad.png', width: 2048, height: 1536 }
          { name: 'Default-Landscape-736h.png', width: 2208, height: 1242 }
        ]
      portrait:
        splashs: [
          { name: 'Default~iphone.png', width: 320, height: 480 }
          { name: 'Default@2x~iphone.png', width: 640, height: 960 }
          { name: 'Default-568h@2x~iphone.png', width: 640, height: 1136 }
          { name: 'Default-Portrait~ipad.png', width: 768, height: 1024 }
          { name: 'Default-Portrait@2x~ipad.png', width: 1536, height: 2048 }
          { name: 'Default-667h.png', width: 750, height: 1334 }
          { name: 'Default-736h.png', width: 1242, height: 2208 }
        ]
  # WebOS
  'webos':
    dir: path.join 'res', 'screen', 'webos'
    layout:
      none:
        splashs: [
          { name: 'screen-64.png', width: 64, height: 64 }
        ]
  # Windows Phone, Tablets and Desktop (Windows 8)
  'windows-phone':
    dir: path.join 'res', 'screen', 'windows-phone'
    layout:
      portrait:
        splashs: [
          { name: 'screen-portrait.png', width: 480, height: 800 }
        ]
