class GoodsController < ApplicationController
  def create
@post = Post.find(params[:post_id])  #create.js.erbで利用するための準備

=begin
current_userの持っているbook_idをfavoritesのbook_idへ
current_userを使いたいから、favoriteモデルはUserモデルともリレーションをもつ。

下記の形で要件定義通りに機能できるのは、Bookコントローラのshowアクションでjoinsを使ってUserモデルと紐づいているため。
模範解答はローカル変数に@book.favorites.new(user_id: current_user.id)を格納している。
自分の作ったものはUserテーブルに新しいレコードを作成しているのに対し、模範解答はBookテーブルに新しいレコードを格納している。
=end
good = current_user.favorites.new(post_id: params[:post_id])
good.save
end

def destroy
@book = Book.find(params[:book_id])
favorite = current_user.favorites.find_by(book_id: params[:book_id])
favorite.destroy
end
end
