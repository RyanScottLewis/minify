class Minify
  class Parser
    class << self
      include MetaTools
      
      # @attr_reader [Hash] index The index of parsers. The key is the mime type and the value is the method to parse it.
      attr_reader :index
      
      # Register a mime type and a method to parse it.
      # We are actually defining a method here so BE SURE to make the first
      # argument `input` and have it return your parsed output.
      # 
      # One method per mime type, so if you register a new method for 'text/html',
      # then the old one will be overwritten with the new one.
      # 
      # @param [String, MIME::Type] mime_type The mime type of the input to parse.
      # @param [Hash] options Options that will be optionally passed to the method.
      # @return [String] The input string, minified.
      def register(mime_type, &blk)
        mime_type = MIME::Types[mime_type].first unless mime_type.is_a?(MIME::Type)
        meth = mime_type.sub_type.gsub(/-/, "_").to_sym
        (@index ||= {})[mime_type.to_s] = meth
        meta_def(meth, &blk)
      end
      
      # Minify the input.
      # 
      # @param [String, MIME::Type] mime_type The mime type of the input.
      # @param [String] input The input string.
      # @param [Hash] options Options to pass to the parser for the given mime type.
      # @return [String] The input string, minified.
      def call(mime_type, input, options={})
        send((@index ||= {})[mime_type], input, options)
      end
      
    end
  end
end
