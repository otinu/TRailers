class GreetMailer < ApplicationMailer
  def greet
    mail(:subject => "デイリーメール", bcc: User.pluck(:email))
  end
end
