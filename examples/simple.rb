$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'minify'

# Set the global options for the given libraries 
Minify::OPTIONS['tidy-ext', 'tidy-fork', 'tidy'] = { 'tidy-mark' => false }

p Minify::Parser.html("<!DOCTYPE html><html>    <head></head>   </html>")
