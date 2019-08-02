Rails.application.routes.draw do
    get '/' => 'top#jp'
    get '/jp' => 'top#jp'
    get '/en' => 'top#en'

    post '/' => 'top#jp'
    post '/en' => 'top#en'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
