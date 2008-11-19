def String.random(len=6)
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  result = ""
  1.upto(len) { |i| result << chars[rand(chars.size-1)] }
  return result
end
