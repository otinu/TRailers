class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    ThanksMailer.send_signup_email(params[:user][:email], params[:user][:name]).deliver if (params[:user][:email]).present?
  end
end
