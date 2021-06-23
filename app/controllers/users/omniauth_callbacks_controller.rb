class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def facebook
    callback_from :facebook
  end

  def google
    callback_from :google
  end

  private

  def callback_from(provider)
    @user = User.find_omniauth(request.env['omniauth.auth'])

    begin
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        SnsLoginMailer.confirmation_email(@user, provider).deliver
      end
    rescue => error
      if Rails.env.development?(@user)
        flash[:notice] = error
        "https://1c0a9f1bb1464501b731b30338cf8bf2.vfs.cloud9.ap-northeast-1.amazonaws.com" && return
      else
        flash[:notice] = error
        "http://trailers.work" && return
      end
    end
  end
end
