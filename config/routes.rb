Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users,only: [:show,:edit,:update]

  resources :posts do
  resource :goods, only: [:create, :destroy,]
  end
  post 'goods' => 'goods#count_view', as: 'goods_count_view'

  get 'chat/:id' => 'chats#show', as: 'chat' #URLを単数形の「chat」にしたいため、記述。
  delete 'chat/:id' => 'chats#destroy', as: 'chat_destroy'
  resources :chats, only: [:create]

end