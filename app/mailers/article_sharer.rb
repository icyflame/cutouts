class ArticleSharer < ActionMailer::Base
  default from: "cutouts@siddharthkannan.in"

  def share_article(article, emails, from_user, share_as)
    @article = article
    @from_username = (share_as && share_as.length > 0) ? share_as : from_user.username
    subject_component = (article.title && article.title.length > 0) ? article.title : "a cutout"
    mail(:to => emails, :subject => "#{@from_username} has shared #{subject_component} with you!")
  end
end
