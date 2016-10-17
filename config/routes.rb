Rails.application.routes.draw do

  get 'api_helpers/password_compare'

	scope '/api' do
		scope '/v1' do
			scope '/articles' do
				post '/' => 'api_helpers#article_create'
				get '/' => 'api_helpers#articles_list'
			end
			scope '/users' do
				post '/' => 'api_helpers#user_create'
				scope '/auth' do
					post '/' => 'api_helpers#user_signin'
				end
			end
		end
	end


  get 'list_articles/index'

  get 'static/index'

  get 'user/index'
  get 'user/export_articles'

  devise_for :users
	resources :article

	get 'users' => 'user#index'

	get 'articles' => 'article#index'

	root 'static#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
