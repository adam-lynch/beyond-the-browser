gulp            = require 'gulp'
$               = require('gulp-load-plugins') gulp
mainBowerFiles  = require 'main-bower-files'
del             = require 'del'
runSequence     = require 'run-sequence'
browserSync     = require('browser-sync').create()


gulp.task 'clean', (done) ->
    del './output', done
    return


gulp.task 'markup', ->
    gulp.src('./src/templates/index.html')
        .pipe $.nunjucksRender
            path: './src/templates'
            data:
                shouldIncludeNavigation: false
                shouldIncludePagination: false
                shouldIncludeScrollbar: false
        .pipe gulp.dest('./output')


gulp.task 'styles', ->
    gulp.src './src/styles/index.less'
        .pipe $.less()
        .pipe $.autoprefixer 'last 2 versions'
        .pipe $.minifyCss()
        .pipe gulp.dest './output'
        .pipe browserSync.stream()


gulp.task 'scripts', ->
    gulp.src './src/script.js'
    .pipe gulp.dest './output'
    .pipe browserSync.stream()


gulp.task 'third-party', ->
    jsFilter = $.filter '**/*.js', { restore: true }
    cssFilter = $.filter '**/*.css', { restore: true }

    gulp.src(mainBowerFiles())
        .pipe jsFilter
        .pipe $.concat 'third-party.js'
        .pipe jsFilter.restore
        .pipe cssFilter
        .pipe $.concat 'third-party.css'
        .pipe cssFilter.restore
        .pipe gulp.dest('./output')
        .pipe browserSync.stream()


gulp.task 'images', ->
    gulp.src './src/images/*'
    .pipe gulp.dest './output/images'
    .pipe browserSync.stream()


gulp.task 'compile', ['third-party', 'markup', 'styles', 'scripts', 'images']


gulp.task 'browser-sync', ->
    browserSync.init
        server: './output'


gulp.task 'watch', ['compile', 'browser-sync'], ->
    gulp.watch './bower.json', ['third-party']
    gulp.watch './src/templates/**/*', ['markup']
    gulp.watch './src/styles/**/*', ['styles']
    gulp.watch './src/*.js', ['scripts']
    gulp.watch './src/images/*', ['images']
    gulp.watch('./output/*.html').on 'change', browserSync.reload


gulp.task 'default', ['compile']