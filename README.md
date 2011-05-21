# minify

__min·i·fy__ _verb_ _\ˈmi-nə-ˌfī\_ __:__ To minimize or reduce.

Minify your files based on their filetype.

__Documentation__

[Gem](http://rubydoc.info/gems/minify/0.1.0/frames)  
[GitHub](http://rubydoc.info/github/c00lryguy/minify)

__Installation__

`gem install minify`

## Usage

__Minify Strings__

    Minify::Parser.call("text/html", "<html>    <head></head>   </html>")
    # => "<html><head></head></html>"

This is the same as:

    Minify::Parser.html("<html>    <head></head>   </html>")

__Minify Directories__

    Minify.minimize('public/index.html', 'public/js/**/*')

This will copy the files to `./.minimize-cache` and minimize the original files. 
If the file we're trying to minimize already exists in the cache and the mtime 
is the same, we leave it alone.

Remember to add `.minimize-cache/**/*` to your `.gitignore` file.

    Minify.maximize('public/index.html', 'public/js/**/*')

If the file we're trying to maximize is in `./.minimize-cache`, then we return 
that files's contents. If not, we simply return it's contents.

__Minify Rack Responses__

Minify also acts as Rack middleware:

    use Minify

## Contributing to gemology

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a testing/unstable/feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile or version.

## Copyright

Copyright (c) 2011 Ryan Scott Lewis. See LICENSE for further details.
