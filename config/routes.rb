Rails.application.routes.draw do

  root 'welcome#index'
  get '/invitation' => 'welcome#invitation'
  resources :rsvps
  get 'rsvps/:id/dietary_restrictions' => 'rsvps#edit_dietary_restrictions', as: 'rsvp_dietary_restrictions'
  patch 'rsvps/:id/dietary_restrictions' => 'rsvps#update_dietary_restrictions'
  post '/rsvps/find_guest' => 'rsvps#find_guest'
  resources :photos
  resources :registries
  get '/login' => 'session#new', as: 'login'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  get '/guests' => 'guests#index', as: 'guests'
  resources :families do
    resources :guests, except: [:index]
  end

end
