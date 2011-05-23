class Minify
  class Parser
    class << self
      include MetaTools
      
      attr_reader :index
      
      def register(mime_type, opts={}, &blk)
        opts = { :require => nil }.merge(opts)
        mime_type = MIME::Types[mime_type].first unless mime_type.is_a?(MIME::Type)
        meth = mime_type.sub_type.gsub(/-/, "_").to_sym
        
        @index ||= {}
        @index[mime_type.to_s] ||= {}
        @index[mime_type.to_s] = @index[mime_type.to_s].merge({
          
        })
        ## TOOODOOO
        ()[mime_type.to_s] = meth
        meta_def(meth, &blk)
      end # Parser.register
      
      def call(mime_type, input)
        @index ||= {}
        send(@index[mime_type], input)
      end # Parser.call
      
      #---
      # HELPER METHODS
      #+++
      
      # Try to require multiple libraries and return the first library that exists
      # and require it
      def use(*libs)
        lib = libs.find do |lib|
          begin
            require lib
            true
          rescue LoadError
            false
          end
        end
        raise(LoadError, "no such files to load -- #{libs.join(", ")}") if lib.nil?
        
        lib
      end # Parser.use
      
    end # << self
  end # Parser
end
