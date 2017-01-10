Rails.application.routes.draw do

  get '/auth/:provider/callback', to:'sessions#create'

  resources :users do
    resources :tasks do
      member do 
        post :set_time_tracking
        post :set_state_tracking
      end
    end

    resources :projects do 
        resources :tasks
    end
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
