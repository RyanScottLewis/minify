require 'rubygems'
require 'bundler/setup'

require 'rack'
require 'mime/types'
require 'meta_tools'
require 'pp'

$LOAD_PATH.unshift(File.dirname(__FILE__))

class Minify
  VERSION = "0.1.2"
end

require 'core_ext/string'
require 'minify/parser'
