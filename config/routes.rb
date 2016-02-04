Rails.application.routes.draw do



  devise_for :users

  get '/next-topics/' => 'topics#next_5', as: :next_topics
  get '/previous-topics/' => 'topics#previous_5', as: :previous_topics
  get '/public-topics/' => 'topics#public', as: :public_topics
  get '/filter/' => 'topics#filter', as: :filter_topics
  post '/preview_bookmarks/' => 'bookmarks#preview_bookmarks', as: :preview_bookmarks

  post '/share_bookmark/:id' => 'bookmarks#share_bookmark', as: :share_bookmark

  resources :topics do
    resources :bookmarks do #, only: [:new, :destroy, :edit, :update]
      resources :likes, only: [:create, :destroy]
    end
    #post '/up-vote' => 'votes#up_vote', as: :up_vote
    #post '/down-vote' => 'votes#down_vote', as: :down_vote

  end

  post :incoming, to: 'incoming#create'

  get 'welcome/about'
  get 'welcome/index'
  get 'users/show/:id' => 'users#show', :as => :users_show
  root to: 'welcome#index'

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
