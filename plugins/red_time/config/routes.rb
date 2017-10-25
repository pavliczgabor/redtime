# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'redtime', to: 'redtime#index'
get 'redtime/static/:name', to: redirect('redtime/static/%{name}')