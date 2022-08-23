Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, only: %i(new create)
    resources :courses, only: %i(index show)
    resources :lessons, only: :show
    resources :exams, except: :destroy
    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :courses
      resources :lessons
      resources :words
      resources :users
    end
  end
end
