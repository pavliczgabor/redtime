# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'redtime', to: 'redtime_main#index'
get 'timereport', to: 'redtime_main#time_report'
get 'pages/:page' => 'page#show'