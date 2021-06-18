class HomesController < ApplicationController
  def top
  end

  def about
  end

  def locale
    if ["ja", "en"].include?(params[:locale])
      cookies[:locale] = params[:locale]
      redirect_to :root
    end
  end
end
