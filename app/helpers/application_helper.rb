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
end
