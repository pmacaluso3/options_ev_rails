Rails.application.routes.draw do
  get '/' => 'ev#show'
  get '/ev' => 'ev#show'
  post '/ev' => 'ev#calculate'
end
