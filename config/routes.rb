Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
  end

  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'services#top'
    get 'services/about' => 'services#about', as: 'about'
    get 'customers/mypage' => 'customers#index', as: 'mypage'
    get 'customers/information' => 'customers#show', as: 'customerpage'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    put 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'
    
    resources :services, only: [:index, :edit, :update, :show, :destory]
    
    get '/appointment' => 'appointments#index', as: 'appointment_path'
    get '/chat' => 'appointment_comments#index', as: 'chat_path'

    # get 'rooms/show' => 'room_messages#show'
  end
end
