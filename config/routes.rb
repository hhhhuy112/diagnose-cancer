Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  namespace :admin do
    resources :data_cancers
    resources :users
    resources :knowledges do
    collection do
      get :create_knowledge
    end
  end
  end
end
