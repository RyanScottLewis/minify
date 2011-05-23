# minify

__min·i·fy__ _verb_ _\ˈmi-nə-ˌfī\_ __:__ To minimize or reduce.

Minify your files based on their filetype.

__Documentation__

[Gem](http://rubydoc.info/gems/minify/0.1.0/frames)  
[GitHub](http://rubydoc.info/github/c00lryguy/minify)

__Installation__

`gem install minify`

## Usage

__Minify Strings By Mime Type__

```ruby
require 'minify'

Minify::Parser.html("<html>    <head></head>   </html>")
```

This is the same as:

```ruby
Minify::Parser.call("text/html", "<html>    <head></head>   </html>")
# => "<html><head></head></html>"
```

Easily register a mime type:

```ruby
Minify::Parser.register('text/plain') do |input, options|
  options = {
    :strip => true, :squeeze => true,
    :lstrip => false, :rstrip => false,
  }.merge(options)
  
  output = input.dup
  output.strip! if options[:strip]
  output.rstrip! if options[:rstrip]
  output.lstrip! if options[:lstrip]
  output.squeeze! if options[:squeeze]
  output
end

p Minify::Parser.plain("   Minify    me  please!  ") # => "Minify me please!"
p Minify::Parser.plain("   Minify    me  please!  ", :strip => false) # => " Minify me please! "

class Minify::Parser
  register('text/foobar') do |input|
    "FOOBAR!"
  end
end

p Minify::Parser.foobar("Hello world!") # => "FOOBAR!"
p Minify::Parser.call("text/foobar", "...Hello world?") # => "FOOBAR!"
```

> _WARNING_
> The following isn't functional... yet

__Minify Daemon__

```sh
> cd proj_dir
> minify add public/index.html public/js/**/*.js

Minify has added the following files to the watch list:
  public/index.html
  public/js/plugins.js
  public/js/script.js

> minify start

Minify started

> minify status

Minify is running

> minify stop

Minify stopped

> minify list

Minify is watching:
  public/index.html
  public/js/plugins.js
  public/js/script.js

> minify add public/css/*.css

Minify has added the following files to the watch list:
  public/css/style.css
  public/css/ie.css

> minify remove plugins.js public/**/index.*

Minify has removed the following files to the watch list:
  public/js/plugins.js
  public/index.html

> minify list

Minify is watching:
  public/js/script.js
  public/css/style.css
  public/css/ie.css
```

All watched will copied to `proj_dir/.minify` and the original files will be 
minimized. Whenever the files in `proj_dir/.minify` are changed, we update 
the original files.

Remember to add `.minify/**/*` to your `.gitignore` file if you're using git.

__Minify Rack Responses__

Minify also acts as Rack middleware:

    require 'my_app'
    require 'minify'
    
    use Minify
    run MyApp

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
