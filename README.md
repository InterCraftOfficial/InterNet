# InterNet

The official computer network of InterCraft

## Development

The project uses a Gulpfile to compile all of the sources. There is also a `.env` file, in which you can add a directory to copy compiled files to as you edit, useful if you want to test out the code in OpenComputers as you edit.

```sh
gulp watch        # Compile files as they change
gulp watch-minify # Compile and minify files as they change

gulp build        # Compile the files
gulp build-minify # Compile and minify the files
```
