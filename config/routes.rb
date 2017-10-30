# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'redtime', to: 'redtime#index'
get 'static/:page' => 'staticpage#show'