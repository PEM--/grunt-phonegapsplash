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
  if keyProfile is 'blackberry'
    curProfile = PROFILES[keyProfile]
    dir = curProfile.dir
    for keyLayout of curProfile.layout
      curLayout = curProfile.layout[keyLayout]
      for splash in curLayout.splashs
        EXPECTED_FILES.push path.join EXPECTED_DEST, dir, splash.name

describe 'Reduced mobile set', ->
  it 'should only create splashscreen for only one profile (blackberry)', ->
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
    assert.equal 1, (fs.readdirSync 'tmp/reduced_mobile_set/res/screen').length
    assert.equal 'blackberry',
      (fs.readdirSync 'tmp/reduced_mobile_set/res/screen')[0]
    assert.equal 1,
      (fs.readdirSync 'tmp/reduced_mobile_set/res/screen/blackberry').length
