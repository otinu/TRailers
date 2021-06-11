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
    @user = User.find_omniauth(request.env['omniauth.auth'])  #モデル内のクラスメソッド使用
      
    begin  #例外発生時は実行環境のルートURLへリダイレクト
    if @user.persisted?     #DBへの保存が成功しているか確認
      flash[:notice] = "You have successfully logged in on #{provider}"
      sign_in_and_redirect @user, event: :authentication
      SnsLoginMailer.confirmation_email(@user, provider).deliver
    end
    rescue
      flash[:notice] = "An error has occurred! Sorry, please use normal login"
      if Rails.env == "development" 
        redirect_to "https://1c0a9f1bb1464501b731b30338cf8bf2.vfs.cloud9.ap-northeast-1.amazonaws.com/"
      else
        redirect_to "https://trailers.work"
      end
    end
  end

end