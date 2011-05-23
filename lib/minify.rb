require 'rubygems'
require 'rack'
require 'mime/types'
require 'meta_tools'
require 'pp'

class Minify
  VERSION = "0.1.4"
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'core_ext/string'
require 'minify/parser/class_methods'
require 'minify/parser/registered_mime_types'
