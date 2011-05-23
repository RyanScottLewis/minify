require 'rubygems'
require 'rack'
require 'mime/types'
require 'meta_tools'
require 'pp'

class Minify
  VERSION = "0.1.3"
  class Options
    def Options.[](lib)
      (@opts ||= {})[lib]
    end
    def Options.[]=(*libs, opts)
      libs.each do |lib|
        (@opts ||={})[lib] = opts
      end
    end
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'core_ext/string'
require 'minify/parser/instance_methods'
require 'minify/parser/class_methods'
require 'minify/parser/registered_mime_types'
