class Minify
  class Parser
  
    register 'text/plain' do |input|
      input.trim.strip
    end
    
    register 'text/html', :require => 'tidy_ffi' do |input, options|
      t = TidyFFI::Tidy.new(input)
      t.options = options # http://tidy.sourceforge.net/docs/quickref.html
      t.clean
    end
    
    register 'text/html', :require => %w{tidy-ext tidy-fork tidy} do |input, options|
      Tidy.path = '/usr/lib/tidylib.so'
      Tidy.open(options) do |t|
        t.clean(input)
      end
    end
    
    register 'text/css', :require => 'cssmin' do |input|
      CSSMin.minify(input)
    end
    
    register 'application/javascript', :require => %w{jsmin} do |input|
      JSMin.minify(file)
    end
    
    register 'application/javascript', :require => %w{jsmin_c} do |input|
      @jsmin ||= JSMin.new
      @jsmin.minimize(input)
    end
    
    register 'application/javascript', :require => %w{jsmin-ffi} do |input|
      JsminFFI.minify!(input)
    end
    
  end
end
