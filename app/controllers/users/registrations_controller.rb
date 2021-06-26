class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if (params[:user][:email]).present?
      ThanksMailer.send_signup_email(params[:user][:email], params[:user][:name]).deliver if (params[:user][:email]).blank?
    end
=begin
    begin
      ThanksMailer.send_signup_email(params[:user][:email], params[:user][:name]).deliver if (params[:user][:email]).blank?
    rescue
      redirect_to new_registration_path(resource_name) && return
    end
=end
  end
end
