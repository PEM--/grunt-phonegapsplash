###
# grunt-phonegapsplash
# https://github.com/PEM--/grunt-phonegapsplash
#
# Copyright (c) 2013 Pierre-Eric Marchandet (PEM-- <pemarchandet@gmail.com>)
# Licensed under the MIT licence.
###

'use strict'

assert = require 'assert'
fs = require 'fs'
path = require 'path'

EXPECTED_DEST = path.join 'tmp', 'default_options'
PROFILES = (require '../lib/profiles') prjName: 'Test'

EXPECTED_FILES = []
for keyProfile of PROFILES
  curProfile = PROFILES[keyProfile]
  dir = curProfile.dir
  for keyLayout of curProfile.layout
    if keyLayout is 'landscape'
      curLayout = curProfile.layout[keyLayout]
      for splash in curLayout.splashs
        EXPECTED_FILES.push path.join EXPECTED_DEST, dir, splash.name

describe 'Reduced layout set', ->
  it 'should only create splashscreens for only one layout (landscape)', ->
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
