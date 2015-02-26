gulp = require 'gulp'
gutil = require 'gulp-util'
concat = require 'gulp-concat'
less = require 'gulp-less'
del = require 'del'
coffee = require 'gulp-coffee'
insert = require 'gulp-insert'
prefix = require 'gulp-autoprefixer'
bower = require 'main-bower-files'
filter = require 'gulp-filter'
sourcemaps = require 'gulp-sourcemaps'

build = 'build'

# - - - Build JS - - - #

gulp.task 'build-js', ['clean-js'], ->
  # gulp.src [
  #   'src/setup.coffee',
  #   'src/app/**/*Helper.coffee',
  #   'src/app/**/*Helpers.coffee',
  #   'src/app/**/*Action.coffee',
  #   'src/app/**/*Actions.coffee',
  #   'src/app/**/*Store.coffee',
  #   'src/app/**/*Component.coffee'
  #   'src/app/**/*View.coffee',
  #   'src/app/**/*Page.coffee',
  #   'src/mount.coffee'
  # ]
  gulp.src ['src/setup.coffee', 'src/app/**/*.coffee', 'src/mount.coffee']
    .pipe sourcemaps.init()
    .pipe coffee()
    .on 'error', gutil.log
    .pipe concat 'main.js'
    .pipe sourcemaps.write()
    .pipe gulp.dest "./#{build}"

gulp.task "clean-js", (cb) -> del(["./#{build}/main.js"], cb)

# - - - Build CSS - - - #

gulp.task 'build-css', ['clean-css'], ->

  gulp.src ['src/styles/defaults.less', 'src/app/**/*.less']
    .pipe sourcemaps.init()
    .pipe insert.prepend "@import 'mixins';"
    .pipe less(paths:['./src/styles'])
    .on 'error', ((err) -> gutil.log(err); @emit('end'))
    .pipe prefix("last 1 version", "> 1%", "ie 9")
    .pipe concat('main.css')
    .pipe sourcemaps.write()
    .pipe gulp.dest "./#{build}"

gulp.task "clean-css", (cb) -> del(["./#{build}/main.css"], cb)

# - - - Build Libraries - - - #

gulp.task 'build-libs', ['clean-libs'], ->

  onlyJS = filter('**/*.js')

  gulp.src bower(), base:'./bower_components'
    .pipe onlyJS
    .pipe sourcemaps.init()
    .pipe concat 'libs.js'
    .pipe sourcemaps.write()
    .pipe onlyJS.restore()
    .pipe gulp.dest "./#{build}"

gulp.task "clean-libs", (cb) -> del(["./#{build}/libs.js"], cb)

gulp.task 'build', ['build-css', 'build-libs', 'build-js']

gulp.task "clean", (cb) -> del(["/#{build}/**"], cb)

gulp.task "watch", ['build'], ->
  gulp.watch('./src/**/*.less', ['build-css'])
    .on('error', gutil.log)

  gulp.watch('./src/**/*.coffee', ['build-js'])
    .on('error', gutil.log)

gulp.task 'default', ['build']

gulp.task "clean-assets", (cb) -> del(["./assets/**"], cb)

gulp.task 'prepare', ['build', 'clean-assets'], ->
  gulp.src(["./#{build}/**"])
    .pipe(gulp.dest "./assets")
