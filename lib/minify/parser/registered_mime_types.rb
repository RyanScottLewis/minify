class Minify
  class Parser
    
    register 'text/html' do |input, options={}|
      require 'tidy_ffi'
      t = TidyFFI::Tidy.new(input)
      t.options = options # http://tidy.sourceforge.net/docs/quickref.html
      t.clean
    end
    
    register 'text/css' do |input|
      require 'cssmin'
      CSSMin.minify(input)
    end
    
    register 'application/javascript' do |input|
      require 'jsmin-ffi'
      JsminFFI.minify!(input)
    end
    
  end
end
