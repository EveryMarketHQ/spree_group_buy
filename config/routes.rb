Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :products do
    	resources :spree_group_buys do
	        collection do
	          post :update_positions
	        end
	    end
    end
  end
end
