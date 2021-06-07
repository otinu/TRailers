class DailyMailer < ApplicationMailer

  def confirmation
      mail(:subject => "デイリーメール", bcc: User.pluck(:email))
  end

end