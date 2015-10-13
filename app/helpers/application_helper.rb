module ApplicationHelper

  def truncate str, length=300
    if str.length > length
      "#{ str[0..length] }..."
    else
      str
    end
  end

end
