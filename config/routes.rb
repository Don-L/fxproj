Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'exchange_rates#index'

  resources :exchange_rates
  resources :conversions

  get 'conversions/index'

  get ':controller/:action/:date/:base/:counter/:amount'

end
