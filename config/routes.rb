Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
      get 'customers/mypage' => 'customers#show', as: 'mypage'
      get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
      patch 'customers/information' => 'customers#update', as: 'update_information'
      put 'customers/information' => 'customers#update'
      get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
      patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
      put 'customers/withdraw' => 'customers#withdraw'
  
      resources :services, only: [:index, :edit, :update, :show, :destory]
  
      get 'rooms/show' => 'room_messages#show'
    end
  end
  
end
