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
        mime_type = MIME::Types[mime_type].first unless mime_type.is_a?(MIME::Type)
        meth = mime_type.sub_type.gsub(/-/, "_")
        (@index ||= {})[mime_type.to_s] = meth
        meta_def(meth, &blk)
      end # Parser.register
      
      def call(mime_type, input)
        send(@index[mime_type], input)
      end # Parser.call
      
    end # << self
    
    # Try to require multiple libraries
    def use(*libs)
      lib = libs.find do |lib|
        begin
          require lib # Returns true if the file is required =)
        rescue LoadError
          false
        end
      end
      raise(LoadError, "no such files to load -- #{libs.join(", ")}") if lib.nil?
      
      lib
    end # Parser#use
      
  end # Parser
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

# Minify::Parser.new.use('yaml', 'json', :as => :Foo)
