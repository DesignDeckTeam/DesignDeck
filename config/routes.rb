Rails.application.routes.draw do
  devise_for :users
  namespace :account do
    resources :orders do
      post :choose_style
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :designer do
    resources :orders do
      post :designer_submit_sample
      resources :versions
    end
    resources :profiles 
  end

  root "landing#index"
end
