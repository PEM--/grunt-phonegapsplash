assert = require 'assert'
fs = require 'fs'

describe 'Reduced set', ->
  it 'should only create splashscreen for only one profile (blackberry)', ->
    EXPECTED_FILES= [
      'tmp/reduced_mobile_set/res/screen/blackberry/screen-225.png'
    ]
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
    assert.equal 1, (fs.readdirSync 'tmp/reduced_mobile_set/res/screen').length
    assert.equal 'blackberry',
      (fs.readdirSync 'tmp/reduced_mobile_set/res/screen')[0]
    assert.equal 1,
      (fs.readdirSync 'tmp/reduced_mobile_set/res/screen/blackberry').length
