Rails.application.routes.draw do
  resources :tags
  resources :documents

  root 'documents#index'
end
