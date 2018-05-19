const jetpack   = require("fs-jetpack");
const gulp      = require("gulp");
const luaminify = require("gulp-luaminify");
const multiDest = require("gulp-multi-dest");
const plumber   = require("gulp-plumber");
const watch     = require("gulp-watch");

const SOURCE       = "./src";
const DESTINATIONS = ["./dist"];

require("dotenv").config()

if (process.env.COPY_TO) {
	DESTINATIONS.push(
		jetpack.path(process.env.COPY_TO, "network")
	);
}

gulp.task("watch", function() {
	gulp.src(SOURCE + "/**/*", {base: SOURCE})
		.pipe(watch(SOURCE, {base: SOURCE}))
		.pipe(plumber())
		.pipe(multiDest(DESTINATIONS));
});

gulp.task("watch-minify", function() {
	gulp.src(SOURCE + "/**/*", {base: SOURCE})
		.pipe(watch(SOURCE, {base: SOURCE}))
		.pipe(plumber())
		.pipe(luaminify())
		.pipe(multiDest(DESTINATIONS));
});

gulp.task("build", function() {
	gulp.src(SOURCE + "/**/*", {base: SOURCE})
		.pipe(multiDest(DESTINATIONS));
});

gulp.task("build-minify", function() {
	gulp.src(SOURCE + "/**/*", {base: SOURCE})
		.pipe(luaminify())
		.pipe(multiDest(DESTINATIONS));
});
