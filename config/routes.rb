AjaxUpload::Application.routes.draw do
  resources :profiles
  resources :pictures
  resources :users
  root :to => "users#index"
  match "/test" => "users#index"

  #ADD THIS: remote url
  scope "/remote" do 
    match "/show_pic" => "pictures#show_pic"
    match "/show_crop" => "pictures#show_crop"
  end
end
