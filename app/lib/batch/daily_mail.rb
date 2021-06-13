class Batch::DailyMail
  def self.greet_mail
    GreetMailer.greet.deliver_now
  end
end
