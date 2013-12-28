assert = require 'assert'
fs = require 'fs'

describe 'Default options', ->
  it 'should create all icons for each default profiles', ->
    EXPECTED_FILES= [
      'tmp/default_options/icon.png'
      'tmp/default_options/res/icon/android/icon-36-ldpi.png'
      'tmp/default_options/res/icon/android/icon-48-mdpi.png'
      'tmp/default_options/res/icon/android/icon-72-hdpi.png'
      'tmp/default_options/res/icon/android/icon-96-xhdpi.png'
      'tmp/default_options/res/icon/bada/icon-48-type5.png'
      'tmp/default_options/res/icon/bada/icon-50-type3.png'
      'tmp/default_options/res/icon/bada/icon-80-type4.png'
      'tmp/default_options/res/icon/bada/icon-128.png'
      'tmp/default_options/res/icon/blackberry/icon-80.png'
      'tmp/default_options/res/icon/ios/icon57.png'
      'tmp/default_options/res/icon/ios/icon72.png'
      'tmp/default_options/res/icon/ios/icon57-2x.png'
      'tmp/default_options/res/icon/ios/icon-72-2x.png'
      'tmp/default_options/res/icon/tizen/icon-128.png'
      'tmp/default_options/res/icon/webos/icon-64.png'
      'tmp/default_options/res/icon/windows-phone/icon-48.png'
      'tmp/default_options/res/icon/windows-phone/icon-62-tile.png'
      'tmp/default_options/res/icon/windows-phone/icon-173-tile.png'
    ]
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
