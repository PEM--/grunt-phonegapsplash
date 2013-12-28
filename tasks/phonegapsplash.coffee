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

###
# All profiles for every splashscreens covered by PhoneGap are stored hereafter.
# The name of the splashscreens is used as the final name under
#  rendered splashscreen..
# The size are the targeted size expected for each splashscreen.
###
PROFILES = {
  # Android
  'android':
    dir: 'res/icon/android/'
    layout:
      landscape:
        splashs: [
          { name: 'screen-ldpi-landscape.png', width: 320, height: 200 }
          { name: 'screen-mdpi-landscape.png', width: 480, height: 320 }
          { name: 'screen-hdpi-landscape.png', width: 800, height: 480 }
          { name: 'screen-hdpi-landscape.png', width: 1280, height: 720 }
        ]
      portrait:
        splashs: [
          { name: 'screen-ldpi-portrait.png', width: 200, height: 320 }
          { name: 'screen-mdpi-portrait.png', width: 320, height: 480 }
          { name: 'screen-hdpi-portrait.png', width: 480, height: 800 }
          { name: 'screen-hdpi-portrait.png', width: 720, height: 1280 }
        ]
  # Bada and Bada WAC
  'bada':
    dir: 'res/icon/bada/'
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
    dir: 'res/icon/blackberry/'
    layout:
      none:
        splashs: [
          { name: 'screen-225.png', width: 225, height: 225 }
        ]
  # iOS (Retina and legacy resolutions)
  'ios':
    dir: 'res/icon/ios/'
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
    dir: 'res/icon/webos/'
    layout:
      none:
        splashs: [
          { name: 'screen-64.png', width: 64, height: 64 }
        ]
  # Windows Phone, Tablets and Desktop (Windows 8)
  'windows-phone':
    dir: 'res/icon/windows-phone/'
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
    # Default options are set to produce all stores icons.
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
    async.each options.profiles, (profile, nextProfile) ->
      grunt.log.debug "Profile: #{profile}"
      # Create a directories for each profile
      grunt.file.mkdir "#{DEST}/#{PROFILES[profile].dir}"
      async.each PROFILES[profile].icons, (destIcon, nextIcon) ->
        # Create the icon in the appropriate directory.
        # The background icon is transparent.
        # The density of the SVG is multiply by 4 so that it gets
        #  antialiased when resized and written to disk.
        grunt.log.debug "#{SRC} -> ",
          "#{DEST}/#{PROFILES[profile].dir}/#{destIcon.name}"
        gm(SRC).
          background('none').
          density(destIcon.size*4, destIcon.size*4).
          resize(destIcon.size, destIcon.size, '!').
          write "#{DEST}/#{PROFILES[profile].dir}/#{destIcon.name}", (err) ->
            return nextIcon err if err
            nextIcon()
      , nextProfile
    , (err) ->
      if err
        grunt.log.error err.message
        done false
      done()
