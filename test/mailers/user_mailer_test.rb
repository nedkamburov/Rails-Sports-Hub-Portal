require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "newsletter_mailer" do
    mail = UserMailer.newsletter_mailer
    assert_equal "Newsletter mailer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
