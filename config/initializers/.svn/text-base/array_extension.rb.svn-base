class Array
  def to_csv
    str=''
    self.each do |row|
      str += '"' + row.collect{|r| r.to_s.gsub(/"/,'\"')}.join('","') + "\"\n"
    end
    str
  end
end

class Hash
  def only_valid_keys(valid_keys)
    params_out = {}

    self.each{|key, value|
      if valid_keys.include? key
        params_out[key] = value
      end
    }

    params_out
  end
end