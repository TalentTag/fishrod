module ApplicationHelper

  def sources
    %w(vk facebook)
  end

  def truncate text, length=300
    return text if text.length<=length
    return "#{ text[0..length-1].strip }..."
  end

end
