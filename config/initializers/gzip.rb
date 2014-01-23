def gzdeflate(s)
	Zlib::Deflate.new(nil, -Zlib::MAX_WBITS).deflate(s, Zlib::FINISH)
end

def gzinflate(s)
	inflater = Zlib::Inflate.new(-Zlib::MAX_WBITS)
  inflater.inflate(s) + inflater.finish()
end