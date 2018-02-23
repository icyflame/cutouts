module ArticleHelper
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
end
