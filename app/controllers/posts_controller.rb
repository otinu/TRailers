class PostsController < ApplicationController

  def new
    @new_post = Post.new
  end

  def show
   @post = Post.find(params[:id])
  end

def index
@posts = Post.all
end


def create
post = Post.new(post_params)
post.user_id = current_user.id    # joinsを使わなくとも、current_userが活用できる場合はこのような方法も可
if post.save
flash[:notice] = "successfully!"
redirect_to user_path(current_user)
else
flash[:alert] = "error / can't be blank or over 200words"
flash[:notice] = "can't be blank"
redirect_to posts_path
end
end

def edit
@post = Post.find(params[:id])
unless current_user.id == @post.user_id
redirect_to posts_path
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
redirect_to posts_path
end

private

def post_params
params.require(:post).permit(:title, :explanation, :user_id, :post_file)
end
end
