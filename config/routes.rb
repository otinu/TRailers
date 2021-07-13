Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get "home/locale" => "homes#locale", as: "locale"

  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: [:show, :edit, :update] do
    collection do
      patch 'count_view_mine'
      put 'count_view_others'
    end
  end

  get 'search' => 'posts#search'
  resources :posts do
    resource :goods, only: [:create, :destroy]
  end

  get 'chat/:id' => 'chats#show', as: 'chat'
  delete 'chat/:id' => 'chats#destroy', as: 'chat_destroy'
  post 'chats' => 'chats#create', as: 'chats'

  get 'notifications' => 'notifications#index', as: 'notifications'
  delete 'notifications' => 'notifications#destroy_all_your_notifications', as: 'destroy_all_your_notifications'
end
