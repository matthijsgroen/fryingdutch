module SearchHelper

  def hl(text, highlight)
    org_text = text
    highlights = highlight.upcase.split
    text = [text.upcase + "\0"]
    highlights.each do |term|
      new_text = []
      text.each { |element| new_text << element.split(term).join("\0#{term}\0").split("\0") }
      text = new_text.flatten
    end
    ri = 0
    r = ""
    text.flatten.each do |i| 
      word = org_text[ri, i.length]
      r += (highlights.include? i) ? "<strong>#{h(word)}</strong>" : h(word)
      ri += word.length
    end
    r
  end

end
