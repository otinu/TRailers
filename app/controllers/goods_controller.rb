class GoodsController < ApplicationController
  def create
@post = Post.find(params[:post_id])  #create.js.erbで利用するための準備

=begin
current_userの持っているpost_idをfavoritesのpost_idへ
current_userを使いたいから、favoriteモデルはUserモデルともリレーションをもつ。

下記の形で要件定義通りに機能できるのは、postコントローラのshowアクションでjoinsを使ってUserモデルと紐づいているため。
模範解答はローカル変数に@post.favorites.new(user_id: current_user.id)を格納している。
自分の作ったものはUserテーブルに新しいレコードを作成しているのに対し、模範解答はpostテーブルに新しいレコードを格納している。
=end
good = current_user.goods.new(post_id: params[:post_id])
good.save
end

def destroy
@post = Post.find(params[:post_id])
favorite = current_user.goods.find_by(post_id: params[:post_id])
favorite.destroy
end
end
