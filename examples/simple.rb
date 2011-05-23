$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'minify'

input = "<!DOCTYPE html><html>    <head></head>   </html>"

p Minify::Parser.html(input, :tidy_mark => false)
