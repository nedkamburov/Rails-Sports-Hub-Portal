# Run in terminal with: $ rake weekly_newsletter_email

desc 'weekly newsletter email'
task weekly_newsletter_email: :environment do
  UserMailer.newsletter_mailer.deliver!
end