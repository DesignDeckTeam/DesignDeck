Rails.application.routes.draw do
  # get 'designers/show'

  devise_for :users

  namespace :account do
    resources :orders do
      post :pay_with_alipay
      post :select_version
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :designer do
    resources :orders do
      post :submit_versions
      post :pick_order
      resources :stages do
        resources :versions
      end
    end
    resources :profiles
  end

  resources :designers, only: [:show, :edit, :update]

  #   resources :orders do
  #     post :submit_versions
  #     resources :versions
  #   end
  # end

  root "landing#index"
end
