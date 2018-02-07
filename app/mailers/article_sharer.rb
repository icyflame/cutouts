class ArticleSharer < ActionMailer::Base
  default from: "cutouts@siddharthkannan.in"

  def share_article(article, emails, from_user)
    @article = article
    @from_username = from_user.username
    mail(:to => emails, :subject => "#{from_user.username} shared a cutout with you!")
  end
end
