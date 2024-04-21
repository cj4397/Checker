Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post '/verify_site' => 'exam#verify_site'
  post '/home' => 'exam#home'
  post '/get_matched' => 'exam#get_matched'
  post '/find_agent' => 'exam#find_agent'

  # Defines the root path route ("/")
  # root "posts#index"
end
