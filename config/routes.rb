Rails.application.routes.draw do
  resources :url, only: [:index, :create, :edit]
  get 'r/:short_url', to: 'url#redirect', as: "shorted_redirect"
  root to: "url#index"
end
