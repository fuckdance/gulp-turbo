gulp       = global.globalGulp or require 'gulp'
pkg        = global.pkg
util       = require 'gulp-util'
stylus     = require 'gulp-stylus'
sourcemaps = require 'gulp-sourcemaps'
through    = require 'through2'
_          = require 'lodash'
path       = require 'path'
define     = require './define'

{base,approot,distMode,distPath} = pkg

# stylus - with sourcemaps
gulp.task 'stylus', ()->
    isCompress= distMode is 'dist'
    util.log 'is Compress mode : ',isCompress
    gulp.src [base+'/'+approot+'/src/stylus/**/*.styl','!'+base+'/'+approot+'/src/stylus/module/**/*.styl']
    .pipe sourcemaps.init()
    .pipe stylus
            compress: isCompress
    .pipe sourcemaps.write '.maps'
    .pipe gulp.dest base+'/'+distPath+'/css/'
    .pipe through.obj (file, enc, cb)->
        util.log 'file.path',file.path
        if(path.extname(file.path) !=".map")
          util.log 'compress ', path.basename(file.path), ' --> ', file.contents.length, 'bytes'
        cb()
