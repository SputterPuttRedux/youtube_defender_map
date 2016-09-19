Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/map/index' => 'map#index', as: :map
  get '/videos/show' => 'videos#show', as: :videos
end
