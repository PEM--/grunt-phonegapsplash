###
# grunt-svg2storeicons
# https://github.com/PEM/grunt-svg2storeicons
#
# Copyright (c) 2013 Pierre-Eric Marchandet (PEM-- <pemarchandet@gmail.com>)
# Licensed under the MIT license.
###

'use strict'

module.exports = (grunt) ->
  
  # Load all tasks plugins declared in package.json
  ((require 'matchdep').filterDev 'grunt-*').forEach grunt.loadNpmTasks

  # Load linter options
  coffeeLintOptions = grunt.file.readJSON './coffeelint.json'
  
  # Project configuration.
  grunt.initConfig
    # Lint all CoffeeScript files
    coffeelint:
      all: [
        'Gruntfile.coffee'
        'tasks/*.coffee'
        'test/*.coffee'
      ]
      options: coffeeLintOptions
    
    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]
    
    # Configuration to be run (and then tested).
    svg2storeicons:
      # Test icon creation for all profiles
      default_options:
        src: 'test/fixtures/icon.svg'
        dest: 'tmp/default_options'
      # Test icon creation for a single
      reduced_set:
        src: 'test/fixtures/icon.svg'
        dest: 'tmp/reduced_set'
        options:
          profiles: ['blackberry']
    
    # Unit tests.
    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script'
        src: ['test/*.coffee']
  
  # Actually load this plugin's task(s).
  grunt.loadTasks "tasks"
  
  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask 'test', [
    'clean'
    'svg2storeicons'
    'mochaTest'
  ]
  
  # By default, lint and run all tests.
  grunt.registerTask 'default', [
    'coffeelint'
    'test'
  ]
