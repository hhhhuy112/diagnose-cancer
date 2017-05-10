Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "static_pages#home"
  get  '/breast_cancer', to: "static_pages#breast_cancer"
  get  '/data_mining', to: "static_pages#data_mining"
  get  '/data_set', to: "static_pages#data_set"
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
  resources :test_algorithms
  resources :user_groups
  resources :fictions
  resources :abouts
  namespace :admin do
    root "users#index"
    resources :data_cancers
    resources :users
    resources :fictions
    resources :value_fictions
    resources :test_algorithms
    resources :diagnoses
    resources :groups
    resources :user_groups
    resources :rules
    resources :rule_id3s
    resources :abouts
    resources :knowledges do
      collection do
        get :create_knowledge
      end
    end
  end
end
