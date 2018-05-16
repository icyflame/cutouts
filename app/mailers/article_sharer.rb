class ArticleSharer < ActionMailer::Base
  default from: "Cutouts <cutouts@siddharthkannan.in>"
  layout "mailer"
  add_template_helper(ApplicationHelper)

  def share_article(article, emails, from_user, share_as, cc_author, comments)
    @article = article
    @from_username = (share_as && share_as.length > 0) ? share_as : from_user.username
    @comments = comments
    subject_component = (article.title && article.title.length > 0) ? article.title : "a cutout"

    cc_emails = [ ]
    if cc_author
      cc_emails.push(from_user.email)
    end

    mail(:to => emails, cc: cc_emails, :subject => "#{@from_username} has shared #{subject_component} with you!")
  end
end
