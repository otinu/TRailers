Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users,only: [:show,:edit,:update] do
    collection do
      patch 'count_view_mine'
        put 'count_view_others'
    end
  end

  resources :posts do
  resource :goods, only: [:create, :destroy,]
  end

  get 'search' => 'posts#search'

  get 'chat/:id' => 'chats#show', as: 'chat' #URLを単数形の「chat」にしたいため、記述。
  delete 'chat/:id' => 'chats#destroy', as: 'chat_destroy'
  resources :chats, only: [:create]

  get 'notifications' => 'notifications#index', as: 'notifications'
  delete 'notifications' => 'notifications#destroy_all_your_notifications', as: 'destroy_all_your_notifications'

end