Rails.application.routes.draw do

    root "games#index"

    resources :streams, only: [:index, :show]

    get '/twitch', to: 'streams#twitch'
    get '/hitbox', to: 'streams#hitbox'

    resources :games

    get '/search', to: 'games#search'

end
