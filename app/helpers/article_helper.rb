module ArticleHelper
  include ApplicationHelper
  def allowed_params
    forbidden_params = [ "id", "created_at", "updated_at", "user_id" ]
    Article.column_names.select { |s| !forbidden_params.include? s }
  end

  def get_article_params inp
    required_keys = allowed_params
    inp.select { |k, v| required_keys.include? k.to_s }
  end

  def show_allowed article
    !article.closed?
  end

  def viz_int_val viz
    Article.visibilities[viz]
  end

  def viz_icon viz
    ind = viz
    if viz.is_a? String
      ind = viz_int_val viz
    end

    icons = [ "globe", "unlock", "lock" ]
    tips = [ "publicly available", "available only if you share the link", "visible only to you" ]

    fa_icon(icons[ind], class: "fa-2x", title: tips[ind])
  end

  def link_placeholder link
    link.slice(0, 10) + "..."
  end

  def link_host object
    link_valid = object.link =~ URI::regexp
    if link_valid
      URI(object.link).host
    else
      link_placeholder(object.link)
    end
  end

  def article_title object
    title_exists = object.title && object.title.length > 0
    if title_exists
      object.title
    else
      link_host object
    end
  end

  def show_url article
    fully_qualified_root_url + "/article/#{article.id}"
  end
end
