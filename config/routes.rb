Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'sessions#guest_sign_in', as: :users_guest_sign_in
  end
  get "up" => "rails/health#show", as: :rails_health_check
  get '/', to: 'home#index'
end
