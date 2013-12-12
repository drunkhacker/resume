'use strict'
mountFolder = (connect, dir) ->
  connect.static require('path').resolve dir

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    connect:
      server:
        options:
          port: 9000
          hostname: '*'
          base: 'dist'
          middleware: (connect) ->
            [ require('connect-livereload')(ignore:[]), mountFolder(connect, '.tmp'), mountFolder(connect, 'dist')]
    watch:
      options:
        livereload: true
      less:
        files:
          ['assets/styles/**/*.less']
        tasks: 'less'
        options:
          livereload: false
      coffee:
        files:
          ['assets/scripts/**/*.coffee']
        tasks: 'coffee'
        options:
          livereload: false
      jade:
        files:
          ['views/**/*.jade']
        tasks: 'jade'
        options:
          livereload: false
      img:
        files:
          ['assets/images/**/*.{png,jpg,jpeg,gif,webp,svg}']
        tasks: 'copy:img'
        options:
          livereload: false
      css:
        files:
            ['assets/styles/**/*.css']
          tasks: 'copy:css'
          options:
            livereload: false
      dist:
        files: ['dist/**', 'dist/img/*.*', 'dist/css/*.*', 'dist/js/*.*']
    coffee:
      compile:
        files: [
          expand: true
          src: '**/*.coffee'
          cwd: 'assets/scripts/'
          dest: 'dist/js'
          ext: '.js'
        ]
    less:
      development:
        files: [
          expand: true
          src: '**/*.less'
          cwd: 'assets/styles/'
          dest: 'dist/css'
          ext: '.css'
        ]
    open:
      # change to the port you're using
      server:
        path: "http://localhost:<%= connect.server.options.port %>?LR-verbose=true"
    jade:
      compile:
        files: [
          expand: true
          src: '**/*.jade'
          cwd: 'views/'
          dest: 'dist/'
          ext: '.html'
        ]
    copy:
      img:
        files: [
            expand: true
            src: ['**/*.{png,jpg,jpeg,gif,webp,svg}']
            cwd: 'assets/images'
            dest: 'dist/img/'
        ]
      fonts:
        files: [
          expand: true
          src: '**/*.{eot,ttf,woff}'
          cwd: 'assets/fonts'
          dest: 'dist/fonts/'
        ]
      css:
        files: [
          expand: true
          src: '**/*.css'
          cwd: 'assets/styles'
          dest: 'dist/css/'
        ]
      javascripts: 
        files: [
          expand: true
          src: '**/*.js'
          cwd: 'assets/scripts'
          dest: 'dist/js/'
        ]
      main:
        files: [
            expand: true
            src: ['**/*.*']
            cwd: 'assets/images'
            dest: 'dist/img/'
          ,
            expand: true
            src: ['**/*.js']
            cwd: 'assets/scripts'
            dest: 'dist/js/'
        ]
      bower_components:
        files: [
          expand: true
          src: '**/*.*'
          cwd: 'bower_components'
          dest: 'dist/bower_components'
        ]

    clean: ['dist']

  grunt.registerTask 'server', [ 'clean', 'copy', 'jade', 'less', 'coffee', 'connect:server', 'open', 'watch' ]


