module ApplicationHelper

  def sources
    SourceMap.all.keys
  end

  def current_location
    request.path
  end

end
