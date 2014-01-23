def highlight_tokens(str, tokens, open_tag='<b>', close_tag='</b>')
  return str if !tokens.kind_of?(Array) || tokens.empty?
  tmp = str + ''
  tokens.each {|token|
    tmp.gsub!(/(#{token})/i, open_tag + '\1' + close_tag)
  }
  tmp
end