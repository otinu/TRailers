class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :trailer, :locale]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  def after_sign_up_path_for(resource)
    posts_path
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def set_locale
    if ["ja", "en"].include?(cookies[:locale])
      I18n.locale = cookies[:locale]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mine_open, :others_open])
  end
end
