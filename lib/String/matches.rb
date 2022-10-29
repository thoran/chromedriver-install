# String/matches
# String#matches

# 20111025
# 0.0.0

class String
  
  def matches(regex)
    if md = self.match(regex)
      [md[0], md.captures].flatten.compact
    else
      nil
    end
  end
  
end
