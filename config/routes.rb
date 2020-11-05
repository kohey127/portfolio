Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'services#top'
    get 'services/about' => 'services#about', as: 'about'
    resources :services do
      get 'appointments/complete' => 'appointments#complete'
      patch 'status' => 'services#status_update', as: 'update_status'
      resources :appointments, only: [:new, :create, :edit, :update]
      resources :comments, only: [:create, :edit]
      resource :favorites, only: [:create, :destroy]
    end
    
    get 'customers/mypage' => 'customers#index', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    put 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    put 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show]
    get 'history' => 'point_histories#index', as: 'point_history'
    
    get 'appointments' => 'appointments#index'
    resources :appointment_comments, only: [:show, :create]
    get 'search' => 'searches#search'

  end
end
