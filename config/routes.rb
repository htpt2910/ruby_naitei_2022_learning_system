Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"

    resources :courses
    resources :lessons
    resources :words
    resources :exams, except: :destroy
    resources :user_learn_words, only: %i(create destroy)
    resources :lessons do
      resources :words, only: :index
    end
    resources :users, only: %i(index destroy)
  end
end
