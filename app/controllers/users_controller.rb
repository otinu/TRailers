class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    unless current_user == @user
      @posts = Post.includes([post_file_attachment: :blob], [:user], [:taggings]).page(params[:page]).where(user_id: @user.id)
      @posts.page(params[:page]).reverse_order
      render "posts/index"
    end
  end

  def edit
    @user = User.find(params[:id])
    render "edit"
  end

  def update
    if @user.update(user_params)
      post = Post.find_by(user_id: current_user.id)
      redirect_to post_path(post) if post.present?
      redirect_to user_path(@user) if post.blank?
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

  def ensure_correct_user # before_action
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
