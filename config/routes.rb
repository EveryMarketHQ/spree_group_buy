Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :products do
    	resources :group_buys
    end
  end
end
