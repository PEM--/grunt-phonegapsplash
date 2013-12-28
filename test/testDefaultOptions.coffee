assert = require 'assert'
fs = require 'fs'

describe 'Default options', ->
  it 'should create all splashscreens for each default profiles and layouts', ->
    EXPECTED_FILES= [
      'tmp/default_options/res/screen/webos/screen-64.png'
      'tmp/default_options/res/screen/blackberry/screen-225.png'
      'tmp/default_options/res/screen/android/screen-ldpi-portrait.png'
      'tmp/default_options/res/screen/android/screen-ldpi-landscape.png'
      'tmp/default_options/res/screen/bada/screen-type5.png'
      'tmp/default_options/res/screen/android/screen-mdpi-landscape.png'
      'tmp/default_options/res/screen/ios/screen-iphone-landscape.png'
      'tmp/default_options/res/screen/android/screen-mdpi-portrait.png'
      'tmp/default_options/res/screen/bada/screen-type3.png'
      'tmp/default_options/res/screen/ios/screen-iphone-portrait.png'
      'tmp/default_options/res/screen/android/screen-hdpi-landscape.png'
      'tmp/default_options/res/screen/android/screen-hdpi-portrait.png'
      'tmp/default_options/res/screen/bada/screen-type4.png'
      'tmp/default_options/res/screen/bada/screen-portrait.png'
      'tmp/default_options/res/screen/windows-phone/screen-portrait.png'
      'tmp/default_options/res/screen/ios/screen-iphone-landscape-2x.png'
      'tmp/default_options/res/screen/ios/screen-iphone-portrait-568h-2x.png'
      'tmp/default_options/res/screen/ios/screen-iphone-portrait-2x.png'
      'tmp/default_options/res/screen/android/screen-xhdpi-landscape.png'
      'tmp/default_options/res/screen/android/screen-xhdpi-portrait.png'
      'tmp/default_options/res/screen/ios/screen-ipad-portrait.png'
      'tmp/default_options/res/screen/ios/screen-ipad-landscape.png'
      'tmp/default_options/res/screen/ios/screen-ipad-portrait-2x.png'
      'tmp/default_options/res/screen/ios/screen-ipad-landscape-2x.png'
    ]
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
