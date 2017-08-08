Rails.application.routes.draw do


  devise_for :users
  resources :wikis
  resources :users
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:create, :destroy]

  post 'downgrade' => 'charges#downgrade'

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
