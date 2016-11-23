Rails.application.routes.draw do

  devise_for :users

  namespace :account do
    resources :orders do
      post :pay_with_alipay
      post :select_version
      post :submit_additional_comment
    end

    resources :samples, only: [:show, :edit]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :designer do
    resources :orders do
      post :submit_versions
      post :pick_order
      post :submit_additional_comment
      resources :stages do
        resources :versions
      end
    end
  end

  resources :designers, only: [:show, :edit, :update]

  get '/orders/:order_id/conversations', to: 'conversations#index', as: 'conversations_for_order'
  get '/orders/:order_id/stages/:stage_id/conversations', to: 'conversations#show', as: 'conversation_for_stage'

  root "landing#index"
  
end
