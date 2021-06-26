class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if (params[:user][:email]).present?
      if resource.valid?
        ThanksMailer.send_signup_email(params[:user][:email], params[:user][:name]).deliver
      end
    end
  end
end
