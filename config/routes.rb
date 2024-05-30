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
    resources :memorial_photos, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :funeral_preferences, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :funeral_hall_map_search, only: [:index]
    resource :birthday, only: [:new, :create, :edit, :update, :destroy]
    resources :insurance_policies, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :insurance_graphs, only: [:index] do
      collection do
        post 'calculate_insurance_amount_by_age'
      end
    end
  end
  resources :contacts, only: [:index, :new, :create] do
    collection do
      post 'confirm'
      post 'done'
    end
  end
end
