# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'redtime', to: 'redtime_main#index'
get 'pages/:page' => 'page#show'