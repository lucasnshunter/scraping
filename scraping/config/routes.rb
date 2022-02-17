Rails.application.routes.draw do
  get 'home/teste'
  root to: "home#teste"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
