class GoodsController < ApplicationController
  def create
    @post = Post.find(params[:post_id]) # create.js.erbで利用するための準備
    @user_mine_open = @post.user.mine_open
    current_user.goods.create(post_id: params[:post_id])

    # 通知機能の作成
    post = Post.find(params[:post_id])
    post.create_notification_goods(current_user, post.user.id, post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user_mine_open = @post.user.mine_open
    Good.it_destroy(current_user, params[:post_id])
  end
end
