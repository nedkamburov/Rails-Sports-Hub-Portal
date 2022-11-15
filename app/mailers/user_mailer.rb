class UserMailer < ApplicationMailer

  def newsletter_mailer
    @newsletter = Newsletter.all
    @articles = Article.last(3)
    emails = @newsletter.collect(&:email).join(", ")
    mail(to: emails, subject: "Sports Hub Portal Weekly Newsletter")
  end
end
