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
RESOLUTION = 2048
# Special values for layout none (squared layout)
OFFSET = 384
NONE_RESOLUTION = 1280

module.exports = (grunt) ->
  grunt.registerMultiTask 'phonegapsplash', \
      'Create PhoneGap splashscreens from a single PNG file.', ->
    # Call this function when inner tasks are achieved.
    done = @async()
    # Default options are set to produce all splashscreens.
    # This setting can be surcharged by user.
    options = @options
      prjName: 'Test'
      layouts: [ 'portrait', 'landscape', 'none' ]
      profiles: [
        'android', 'bada', 'blackberry', 'ios', 'webos', 'windows-phone'
      ],
      useXCAssetsPath: false
    # Get all profiles as constants
    PROFILES = (require '../lib/profiles') options
    # Check existence of source file
    return done new Error "Only one source file is allowed: #{@files}" \
      if @files.length isnt 1 or @files[0].orig.src.length isnt 1
    SRC = @files[0].orig.src[0]
    return done new Error "Source file '#{SRC}' not found: #{@files}" \
      if not grunt.file.exists SRC
    # Get the result's folder
    DEST = @files[0].dest
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
              cropX = cropY = OFFSET
              cropWidth = cropHeight = NONE_RESOLUTION
          # Check if a sub sub path is necessary as Android's splash names
          #  require a specific sub sub directory.
          grunt.file.mkdir path.dirname targetFile
          # Create the splashcreen in the appropriate directory.
          # The source is cropped to fit aspect ratio of target splashcreen
          #  and resized before written.
          grunt.log.debug "gm convert " + \
            "-crop #{cropWidth}x#{cropHeight}+#{cropX}+#{cropY} " + \
            "-resize #{splash.width}x#{splash.height}! " + \
            "#{SRC} #{targetFile}"
          gm(SRC)
            .crop(cropWidth, cropHeight, cropX, cropY)
            .resize(splash.width, splash.height, '!')
            .write targetFile, (err) ->
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
