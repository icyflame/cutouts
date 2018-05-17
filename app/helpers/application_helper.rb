module ApplicationHelper
  def fully_qualified_root_url
    "https://cutouts.siddharthkannan.in"
  end

  def about_page_url
    "#{fully_qualified_root_url}/about"
  end

  def cutouts_show_image_url
    "http://cliparts.co/cliparts/dc4/okg/dc4okgKxi.jpg"
  end

  def user_public_page_url username
    "#{fully_qualified_root_url}/#{username}"
  end

  def understand_query query
    tags = [ ]
    terms = [ ]

    tag_re = /tag:([a-z0-9\-]+)/i
    t1 = query.scan(tag_re)

    for i in t1
      if i.length > 0 and i[0].is_a? String
        tags.push i[0]
      end
    end

    return tags, terms
  end
end
