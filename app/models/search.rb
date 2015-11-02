class Search < ActiveRecord::Base

  scope :active, -> { where active: true }


  def pattern
    pt = "(#{ query })"
    pt = pt + " (#{ context.split(',').map(&:strip).join(' | ') })" if context.present?
    pt = pt + ' ' + stopwords.split(',').map {|sw| "!(#{ sw.strip })" }.join(' ') if stopwords.present?
    pt
  end

  def name
    super.presence || query[0..30] rescue 'Untitled'
  end

end
