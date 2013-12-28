assert = require 'assert'
fs = require 'fs'

describe 'Reduced set', ->
  it 'should only create icons for only one profile (blackberry)', ->
    EXPECTED_FILES= [
      'tmp/reduced_set/res/icon/blackberry/icon-80.png'
    ]
    for file in EXPECTED_FILES
      assert.equal true, (fs.statSync file).isFile()
    assert.equal 1, (fs.readdirSync 'tmp/reduced_set').length
    assert.equal 1, (fs.readdirSync 'tmp/reduced_set/res/icon').length
    assert.equal 'blackberry', (fs.readdirSync 'tmp/reduced_set/res/icon')[0]
    
