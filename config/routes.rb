Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :designer do
    resources :orders do
      resources :versions do
        collection do
          post :create_samples
        end
      end
    end
  end


  root 'welcome#index'
end
