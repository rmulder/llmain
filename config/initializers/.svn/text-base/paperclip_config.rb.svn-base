if RUBY_PLATFORM[/mswin|mingw32/i]  # Microsoft Windows
  Paperclip.options[:command_path] = 'C:/opt/ImageMagick-6.6.5-Q16'
elsif RUBY_PLATFORM[/darwin/]       # Mac OS X
  Paperclip.options[:command_path] = '/opt/local/bin'
else                                # Linux
  Paperclip.options[:command_path] = '/usr/local/bin'
end
