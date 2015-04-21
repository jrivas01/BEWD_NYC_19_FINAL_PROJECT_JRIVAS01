Rails.application.routes.draw do

    root "streams#index"

    resources :streams, only: [:index, :show]

    #get '/stream/:', to: 'streams#show'

end
