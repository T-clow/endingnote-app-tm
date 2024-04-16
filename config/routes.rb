Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'registrations'
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'sessions#guest_sign_in', as: :users_guest_sign_in
  end
  get "up" => "rails/health#show", as: :rails_health_check
  get '/', to: 'home#index'

  resources :users do
    resources :will_videos, only: [:new, :create, :show, :edit, :destroy]
    resources :memorial_photos, only: [:new, :create, :show, :edit, :destroy]
    resources :funeral_preferences, only: [:new, :create, :show, :edit, :update, :destroy]
  end
end
