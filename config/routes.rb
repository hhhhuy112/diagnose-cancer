Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :diagnoses
  resources :groups do
    member do
      post :delete_member
    end
    member do
      post :add_member
    end
  end
  resources :user_groups
  namespace :admin do
    root "users#index"
    resources :data_cancers
    resources :users
    resources :fictions
    resources :value_fictions
    resources :diagnoses
    resources :groups
    resources :user_groups
    resources :rules
    resources :rule_id3s
    resources :knowledges do
      collection do
        get :create_knowledge
      end
    end
  end
end
