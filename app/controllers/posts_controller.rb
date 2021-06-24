class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def index
    @posts = Post.includes([post_file_attachment: :blob], [:user], [:taggings]).page(params[:page]).reverse_order
    if params[:taggings]
      @posts = Post.tagged_with("#{params[:taggings]}").includes([post_file_attachment: :blob], [:user], [:taggings]).page(params[:page]).reverse_order
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.post_file.attached?
        redirect_to posts_path
      else
        Post.last.destroy
        @post = Post.new
        flash.now[:warning] = I18n.t("Please attached any file")
        render "new"
      end
    else
      flash.now[:warning] = I18n.t("Please attached any file") unless @post.post_file.attached?
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render "edit", notice: "error / can't be blank or over 200words"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  def search
    posts = Post.search_for(params[:keyword])
    @posts = posts.includes([post_file_attachment: :blob], [:user], [:taggings]).page(params[:page]).reverse_order
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:title, :explanation, :user_id, :post_file, :tag_list)
  end
end
