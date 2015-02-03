Rails.application.routes.draw do

  root 'welcome#index'
  resources :rsvps
  post '/rsvps/find_user' => 'rsvps#find_user'
  resources :photos
  resources :registries

end
