Rails.application.routes.draw do


  devise_for :users

  namespace :admin do
    resources :users do
      post :approve_designer
    end

    resources :orders
  end

  namespace :account do
    resources :orders do
      collection do
        post :rating
      end
      post :pay_with_alipay
      post :select_version
      post :select_draft
      post :submit_additional_comment
      post :complete_order
    end

    resources :samples, only: [:show, :edit, :update]
    resources :versions, only: [:show]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :designer do
    resources :orders do
      post :submit_versions
      post :submit_drafts
      post :pick_order
      post :submit_additional_comment
      resources :stages do
        resources :versions
      end
    end

    resources :samples, only: [:show]
  end

  resources :designers, only: [:show, :edit, :update]


  namespace :admin do
    resources :orders
  end

  get '/orders/:order_id/conversations', to: 'conversations#index', as: 'conversations_for_order'
  get '/orders/:order_id/stages/:stage_id/conversations', to: 'conversations#show', as: 'conversation_for_stage'

  root "landing#index"

end
