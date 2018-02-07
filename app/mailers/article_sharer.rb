class ArticleSharer < ActionMailer::Base
  default from: "cutouts@siddharthkannan.in"

  def share_article(article, emails, from_user)
    @article = article
    @from_username = from_user.username
    subject_component = (article.title && article.title.length > 0) ? article.title : "a cutout"
    mail(:to => emails, :subject => "#{from_user.username} has shared #{subject_component} with you!")
  end
end
