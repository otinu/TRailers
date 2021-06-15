class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    ThanksMailer.send_signup_email(params[:user][:email], params[:user][:name]).deliver unless {"email" => ""}.present?  #devise側で登録が完了した場合のみ、メーラー起動
  end
end
