Rails.application.routes.draw do


  resources :password_resets, except: [:index, :destroy]

  root 'home#index'

end
