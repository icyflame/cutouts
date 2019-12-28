module ArticleHelper
  include ApplicationHelper
  def allowed_params
    forbidden_params = [ "id", "created_at", "updated_at", "user_id" ]
    Article.column_names.reject { |k| forbidden_params.include? k }
  end

  def get_article_params params
    params.select! { |k| allowed_params.include? k.to_s }
    fix_types params.stringify_keys.to_unsafe_h
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

  private

  def fix_types article
    article.merge "visibility" => article["visibility"].to_i
  end
end
