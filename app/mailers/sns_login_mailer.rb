class SnsLoginMailer < ApplicationMailer
  def confirmation_email(user, provider)
    @user = user
    @sns = user.sns_credentials.find_by(user_id: user.id, provider: provider)
    mail to: user.email, subject: 'TRailersへようこそ！'
  end
end
