# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'redtime', to: 'redtime_main#index'
get 'redtime/timereport/filter', to: 'time_report#filter'
get 'redtime/timereport/report', to: 'time_report#report'
get 'redtime/timecomparisonreport/filter', to: 'time_comparison_report#filter'
get 'redtime/timecomparisonreport/report', to: 'time_comparison_report#report'
get 'pages/:page' => 'page#show'

get 'timevisualizer', to: 'time_visualizer#index'