AjaxUpload::Application.routes.draw do
  resources :uploads
  root :to => "home#index"

  scope "/remote" do 
    match "/show_pic" => "uploads#show_pic"
    match "/show_crop" => "uploads#show_crop"
  end
end
