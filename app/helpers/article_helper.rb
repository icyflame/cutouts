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
end
