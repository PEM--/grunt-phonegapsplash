###
# grunt-phonegapsplash
# https://github.com/PEM--/grunt-phonegapsplash
#
# Copyright (c) 2013 Pierre-Eric Marchandet (PEM-- <pemarchandet@gmail.com>)
# Licensed under the MIT licence.
###

'use strict'

# GraphicsMagick (node-gm) is used for cropping and resizing tasks.
gm = require 'gm'
# Async is used to transform this task as an asynchronous task.
async = require 'async'
# Path from NodeJS app is used to merge directory and sub drectories.
path = require 'path'

# Main splashscreen resolution (a squared PNG)
RESOLUTION = 2008

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
PROFILES = {
  # Android
  'android':
    dir: 'res/screen/android/'
    layout:
      landscape:
        splashs: [
          { name: 'screen-ldpi-landscape.png', width: 320, height: 200 }
          { name: 'screen-mdpi-landscape.png', width: 480, height: 320 }
          { name: 'screen-hdpi-landscape.png', width: 800, height: 480 }
          { name: 'screen-xhdpi-landscape.png', width: 1280, height: 720 }
        ]
      portrait:
        splashs: [
          { name: 'screen-ldpi-portrait.png', width: 200, height: 320 }
          { name: 'screen-mdpi-portrait.png', width: 320, height: 480 }
          { name: 'screen-hdpi-portrait.png', width: 480, height: 800 }
          { name: 'screen-xhdpi-portrait.png', width: 720, height: 1280 }
        ]
  # Bada and Bada WAC
  'bada':
    dir: 'res/screen/bada/'
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
    dir: 'res/screen/blackberry/'
    layout:
      none:
        splashs: [
          { name: 'screen-225.png', width: 225, height: 225 }
        ]
  # iOS (Retina and legacy resolutions)
  'ios':
    dir: 'res/screen/ios/'
    layout:
      landscape:
        splashs: [
          { name: 'screen-iphone-landscape.png', width: 480, height: 320 }
          { name: 'screen-iphone-landscape-2x.png', width: 960, height: 640 }
          { name: 'screen-ipad-landscape.png', width: 1024, height: 783 }
          { name: 'screen-ipad-landscape-2x.png', width: 2008, height: 1536 }
        ]
      portrait:
        splashs: [
          { name: 'screen-iphone-portrait.png', width: 320, height: 480 }
          { name: 'screen-iphone-portrait-2x.png', width: 640, height: 960 }
          {
            name: 'screen-iphone-portrait-568h-2x.png',
            width: 640, height: 1136
          }
          { name: 'screen-ipad-portrait.png', width: 768, height: 1004 }
          { name: 'screen-ipad-portrait-2x.png', width: 1536, height: 2008 }
        ]
  # WebOS
  'webos':
    dir: 'res/screen/webos/'
    layout:
      none:
        splashs: [
          { name: 'screen-64.png', width: 64, height: 64 }
        ]
  # Windows Phone, Tablets and Desktop (Windows 8)
  'windows-phone':
    dir: 'res/screen/windows-phone/'
    layout:
      portrait:
        splashs: [
          { name: 'screen-portrait.png', width: 480, height: 800 }
        ]
}

module.exports = (grunt) ->
  grunt.registerMultiTask 'phonegapsplash', \
      'Create PhoneGap splashscreens from a single PNG file.', ->
    # Call this function when inner tasks are achieved.
    done = @async()
    # Default options are set to produce all splashscreens.
    # This setting can be surcharged by user.
    options = @options
      layouts: [ 'portrait', 'landscape', 'none' ]
      profiles: [
        'android', 'bada', 'blackberry', 'ios', 'webos', 'windows-phone'
      ]
    # Check existence of source file
    return done new Error "Only one source file is allowed: #{@files}" \
      if @files.length isnt 1 or @files[0].orig.src.length isnt 1
    SRC = @files[0].orig.src[0]
    return done new Error "Source file '#{SRC}' not found: #{@files}" \
      if not grunt.file.exists SRC
    # Create the result's folder
    DEST = @files[0].dest
    grunt.file.mkdir DEST
    # Iterate over each selected profile
    async.each options.profiles, (optProfile, nextProfile) ->
      grunt.log.debug "Profile: #{optProfile}"
      # Avoid undefined profile
      curProfile = PROFILES[optProfile]
      return nextProfile() if curProfile is undefined
      # Iterate over each selected layout
      async.each options.layouts, (optLayout, nextLayout) ->
        grunt.log.debug "Layout: #{optLayout}"
        # Avoid undefined layout
        curLayout = curProfile.layout[optLayout]
        return nextLayout() if curLayout is undefined
        # Create a directories for each profile having the selected layout
        grunt.file.mkdir path.join DEST, curProfile.dir
        # Iterate over each splashcreen
        async.each curLayout.splashs, (splash, nextSplash) ->
          targetFile = path.join DEST, curProfile.dir, splash.name
          grunt.log.debug "Creating #{targetFile}"
          # Adjust cropping variables depending on layout
          cropX = cropY = cropWidth = cropHeight = 0
          switch optLayout
            when 'landscape'
              cropX = 0
              cropWidth = RESOLUTION
              cropHeight = Math.floor splash.height * RESOLUTION / splash.width
              cropY = Math.floor (RESOLUTION - cropHeight) / 2
            when 'portrait'
              cropY = 0
              cropHeight = RESOLUTION
              cropWidth = Math.floor splash.width * RESOLUTION / splash.height
              cropX = Math.floor (RESOLUTION - cropWidth) / 2
            else
              cropX = cropY = 362
              cropWidth = cropHeight = 1280
          # Create the splashcreen in the appropriate directory.
          # The source is cropped to fit aspect ratio of target splashcreen
          #  and resized before written.
          grunt.log.debug "gm convert " + \
            "-crop #{cropWidth}x#{cropHeight}+#{cropX}+#{cropY} " + \
            "-resize #{splash.width}x#{splash.height}! " + \
            "#{SRC} #{targetFile}"
          gm(SRC).
            crop(cropWidth, cropHeight, cropX, cropY).
            resize(splash.width, splash.height, '!').
            write targetFile, (err) ->
              grunt.log.ok "Splashcreen #{targetFile} created."
              return nextSplash err if err
              nextSplash()
        , nextLayout
      , nextProfile
    , (err) ->
      if err
        grunt.log.error err.message
        done false
      done()
