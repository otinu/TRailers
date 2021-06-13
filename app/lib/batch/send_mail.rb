class Batch::SendMail
  def self.send_mail
    DailyMailer.confirmation.deliver_now
  end
end
