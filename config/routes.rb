Rails.application.routes.draw do
  resources :votings, only: [ :index, :show ]

  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }
end
