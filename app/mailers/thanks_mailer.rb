class ThanksMailer < ApplicationMailer
  def send_signup_email(email, name)
    @name = name
    mail(to: email)
  end
end
