Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :posts do
    member do
      get :pledge
      post :post_pledge
    end
  end

  root 'home#index'
end
