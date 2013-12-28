assert = require 'assert'
fs = require 'fs'

describe 'Reduced set', ->
  it 'should only create splashscreens for only one layout (landscape)', ->
    EXPECTED_FILES= [
      'tmp/reduced_layout_set/res/screen/android/screen-ldpi-landscape.png'
      'tmp/reduced_layout_set/res/screen/android/screen-mdpi-landscape.png'
      'tmp/reduced_layout_set/res/screen/android/screen-hdpi-landscape.png'
      'tmp/reduced_layout_set/res/screen/android/screen-xhdpi-landscape.png'
      'tmp/reduced_layout_set/res/screen/ios/screen-iphone-landscape.png'
      'tmp/reduced_layout_set/res/screen/ios/screen-iphone-landscape-2x.png'
      'tmp/reduced_layout_set/res/screen/ios/screen-ipad-landscape.png'
      'tmp/reduced_layout_set/res/screen/ios/screen-ipad-landscape-2x.png'
    ]
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
    assert.equal 2, (fs.readdirSync 'tmp/reduced_layout_set/res/screen').length
    assert.equal 4,
      (fs.readdirSync 'tmp/reduced_layout_set/res/screen/android').length
    assert.equal 4,
      (fs.readdirSync 'tmp/reduced_layout_set/res/screen/ios').length
    assert.equal 'android',
      (fs.readdirSync 'tmp/reduced_layout_set/res/screen')[0]
    assert.equal 'ios',
      (fs.readdirSync 'tmp/reduced_layout_set/res/screen')[1]
