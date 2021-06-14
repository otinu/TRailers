class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    unless current_user == @user
      flash[:notice] = "#{@user.name}'s Post"
      render "posts/index"
    end
  end

  def edit
    @user = User.find(params[:id])
    render "edit"
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to posts_path
    else
      render "edit"
    end
  end

  def count_view_mine
    user = current_user
    user.update(mine_open_params)
    redirect_to user_path(current_user)
  end

  def count_view_others
    user = current_user
    user.update(others_open_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def mine_open_params
    params.require(:user).permit(:mine_open)
  end

  def others_open_params
    params.require(:user).permit(:others_open)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
