Rails.application.routes.draw do
  resources :oauth_accounts
  resources :sessions do
    member do
      post :login
      post :logout
    end
  end

end
