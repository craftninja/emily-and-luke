Rails.application.routes.draw do

  root 'welcome#index'
  get '/invitation' => 'welcome#invitation'
  get '/map' => 'welcome#map'
  get '/lodgings' => 'welcome#lodgings'
  get '/sights' => 'welcome#sights'
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
  patch '/guests/:id/invite_update' => 'guests#invite_update', as: 'invite_update'
  resources :families do
    resources :guests, except: [:index]
  end
  resources :gifts, only: [:index, :create, :update]
end
