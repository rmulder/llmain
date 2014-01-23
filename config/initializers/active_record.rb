require 'sti_active_record'

# http://tumblr.bwong.net/post/4993312644/typeerror-cant-modify-frozen-hash-while-using
module ActiveSupport
  module Cache
    class Entry
      def value
        if @value
          compressed? ? Marshal.load(Zlib::Inflate.inflate(@value)) : @value
        end
      end
    end
  end
end