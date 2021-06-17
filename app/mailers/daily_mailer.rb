class DailyMailer < ApplicationMailer
  def confirmation
    mail(bcc: User.pluck(:email))
  end
end
