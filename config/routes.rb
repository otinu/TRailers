Rails.application.routes.draw do
  get 'chats/show'
  get 'chats/create'
  get 'chats/destroy'
  get 'goods/create'
  get 'goods/destroy'
  get 'posts/show'
  get 'posts/index'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
