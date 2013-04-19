BrainstemDemoRails::Application.routes.draw do
  root :to => 'home#home'

  namespace :api do
    namespace :v1 do
      resources :widgets
      resources :features
      resources :locations
    end
  end
end
