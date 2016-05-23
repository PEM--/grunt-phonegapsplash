###
# grunt-phonegapsplash
# https://github.com/PEM/grunt-phonegapsplash
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
    # coffeelint:
    #   all: [
    #     'Gruntfile.coffee'
    #     'tasks/*.coffee'
    #     'test/*.coffee'
    #   ]
    #   options: coffeeLintOptions

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]

    # Configuration to be run (and then tested).
    phonegapsplash:
      # Test splashscreen creation for all layouts for all mobiles
      default_options:
        src: 'test/fixtures/splash.png'
        dest: 'tmp/default_options'
      # Test splashscreen creation for a single mobile
      reduced_mobile_set:
        src: 'test/fixtures/splash.png'
        dest: 'tmp/reduced_mobile_set'
        options:
          profiles: ['blackberry']
      # Test splashscreen creation for a single layout
      reduced_layout_set:
        src: 'test/fixtures/splash.png'
        dest: 'tmp/reduced_layout_set'
        options:
          layouts: ['landscape']

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
    'phonegapsplash'
    'mochaTest'
  ]

  # By default, lint and run all tests.
  grunt.registerTask 'default', [
    # Broken tasks: 'coffeelint'
    'test'
  ]
