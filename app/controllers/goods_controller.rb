class GoodsController < ApplicationController
  def create
@post = Post.find(params[:post_id])  #create.js.erbで利用するための準備
@user_mine_open = @post.user.mine_open
good = current_user.goods.new(post_id: params[:post_id])
good.save
end

def destroy
@post = Post.find(params[:post_id])
@user_mine_open = @post.user.mine_open
favorite = current_user.goods.find_by(post_id: params[:post_id])
favorite.destroy
end

end
