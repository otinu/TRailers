class GoodsController < ApplicationController
  def create
@post = Post.find(params[:post_id])  #create.js.erbで利用するための準備
good = current_user.goods.new(post_id: params[:post_id])
good.mine_open = true
good.others_open = true
good.save
end

def destroy
@post = Post.find(params[:post_id])
favorite = current_user.goods.find_by(post_id: params[:post_id])
favorite.destroy
end

def count_view



redirect_to posts_path

end

end
