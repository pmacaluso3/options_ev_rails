Rails.application.routes.draw do
  get '/' => 'ev#calculate'
  post '/ev' => 'ev#calculate'
end
