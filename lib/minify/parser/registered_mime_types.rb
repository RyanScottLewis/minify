class Minify
  class Parser
  
    register 'text/plain' do |input|
      input.trim.strip
    end
    
    register 'text/html' do |input, options={}|
      require 'tidy_ffi'
      t = TidyFFI::Tidy.new(input)
      t.options = options # http://tidy.sourceforge.net/docs/quickref.html
      t.clean
    end
    
    register 'text/css', :require => 'cssmin' do |input|
      require 'cssmin'
      CSSMin.minify(input)
    end
    
    register 'application/javascript' do |input|
      require 'jsmin-ffi'
      JsminFFI.minify!(input)
    end
    
  end
end
