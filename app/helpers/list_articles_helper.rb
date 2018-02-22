module ListArticlesHelper
  def username_for_user_id user_id
    t = User.find(user_id)
    if t
      t.username
    else
      ""
    end
  end
end
