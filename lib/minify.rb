require 'rubygems'
require 'bundler/setup'

require 'rack'
require 'mime/types'
require 'meta_tools'
require 'pp'

class String
  def constantize
    dup.constantize
  end
  def constantize!
    replace(self)  # TODO
  end
end

class Minify
  VERSION = "0.1.1"
  
  class Parser
    include MetaTools
    class << self
      include MetaTools
      
      def register(mime_type, &blk)
        mime_type = MIME::Types[mime_type.to_s].first unless mime_type.is_a?(MIME::Type)
        meth = mime_type.sub_type.gsub(/-/, "_")
        (@index ||= {})[mime_type.to_s] = meth
        meta_def(meth, &blk)
      end # Parser.register
      
      def call(mime_type, input)
        send(@index[mime_type], input)
      end # Parser.call
      
    end # << self
    
    # List what libraries/gems to use to parse the input
    # We require the first available given library
    def use(*args)
      opts = args.last.is_a?(Hash) ? args.pop : { :as => nil }
      libraries = args
      
      libraries.each_with_index do |lib, i|
        begin
          lib_const = opts[:as] || __method__.constantize
          p lib_const.to_sym, lib
          # Parser.autoload(lib_const.to_sym, lib)
          meta_eval do
            autoload(lib_const.to_sym, lib)
          end
          p autoload?(lib_const.to_sym)
          
          lib_const = Parser.const_get(lib_const.to_sym)
          
          p lib_const
          
          class << lib_const; include MetaTools; end
          lib_const.meta_def(:__lib__) { lib }
          break
        rescue LoadError
          next unless i == libraries.length-1
          raise(LoadError, "no such files to load -- #{libraries.join(", ")}")
        end
      end
      
      self
    end # Parser#use
      
  end # Parser
    
#  class Parser
#    register 'text/plain' do |input|
#      input.trim.strip
#    end
#    
#    register 'text/html' do |input|
#      use 'tidy-ext', 'tidy-fork', 'tidy_ffi', 'tidy', :as => :HTML
#      
#      case HTML.lib
#      when 'tidy' || 'tidy-fork' || 'tidy-ext'
#        HTML.path = '/usr/lib/tidylib.so'
#        Tidy.open(:show_warnings=>true) do |tidy|
#          puts tidy.options.show_warnings
#          tidy.clean(input)
#        end
#      when 'tidy_ffi'
#        TidyFFI::Tidy.new(input).clean
#      end
#    end
#    
#    register 'text/css' do |input|
#      use 'cssmin', :as => :CSS
#      CSS.minify(input)
#    end
#    
#    register 'application/javascript' do |input|
#      use 'jsmin_c', 'Jsmin', 'jsmin_ffi', 'jsmin', :as => :JS
#      
#      case JS.__lib__
#      when 'jsmin_c'
#        JS.new.minimize(input)
#      when 'jsmin' || 'Jsmin'
#        JS.minify(input)
#      when 'jsmin_ffi'
#        JS.minify!(input)
#    end
#  end
#  
#  def self.minimize(*paths)
#  
#  end
#  
#  def self.maximize(*paths)
#  
#  end
#  
#  def self.parse(input)
#  
#  end
#  
#  def initialize(app); @app = app; end
#  
#  def call(env)
#    pp env
#    # status, headers, body = env
#    
#    
#    
#    
#    # content_type = headers["Content-Type"]
#    # mime_type = MIME::Types[content_type]
#    
#    # pp headers
#    # pp body
#    
#    puts "\n+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-\n"
#    
#    @app.call([status, headers, body])
#  end
  
end

Minify::Parser.new.use('yaml', 'json', :as => :Foo)
