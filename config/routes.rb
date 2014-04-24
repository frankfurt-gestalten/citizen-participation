AachenGestalten::Application.routes.draw do

  resources :initiatives, path: 'initiativen', :path_names => {:new => "neu", :edit => "bearbeiten"} do
    resources :comments

    member do
      get 'contact'
      post 'contact', action: 'contact_submit'

      get 'contact_moderator'
      post 'contact_moderator', action: 'contact_moderator_submit'

      post 'subscribe'
      post 'unsubscribe'

      post 'support'
      post 'unsupport'
    end
  end

  match '/feed' => 'initiatives#index',
    :defaults => { :format => 'atom' }

  match '/initiativen_short' => 'initiatives#initiativen_short',
    :defaults => { :format => 'atom' }

  get 'supporter_count', action: 'supporter_count', controller: "initiatives"

  resources :constructions, path: 'baustellen', :except => [:index] do
    resources :comments
  end

  match '/comment_feed' => 'comments#index',
      :defaults => { :format => 'atom' }

  match '/baustellen_rss' => 'constructions#index',
    :defaults => { :format => 'rss' }


  match '/baustellen_feed' => 'constructions#index',
    :defaults => { :format => 'atom' }

  resources :quarters, path: 'stadtteil' do

    member do
      get 'vorlagen'

      get :initiatives
      get :streets

      post 'subscribe'
      post 'unsubscribe'
    end
  end

  resources :antraeges, controller: 'antraege', path: 'vorlagen', :path_names => {:new => "neu", :edit => "bearbeiten"} do
    resources :comments
  end

  resources :blogs, :path_names => {:new => "neu", :edit => "bearbeiten"} do
    resources :comments
  end

  resources :pages, path: 'seite', :path_names => {:new => "neu", :edit => "bearbeiten"}

  get 'einfuehrung' => 'pages#einfuehrung'

  get 'kontakt' => 'pages#contact_form'
  post 'contact_form' => 'pages#contact_submit', action: 'contact_form_submit'

  resources :neuigkeitens, controller: 'neuigkeiten', path: 'veranstaltungen', :path_names => {:new => "neu", :edit => "bearbeiten"}

  resources :banners, :path_names => {:new => "neu", :edit => "bearbeiten"}

  resources :search_subscriptions do
    member do
      get 'confirm'
    end
  end

  resources :categories, :path_names => {:new => "neu", :edit => "bearbeiten"}

  match 'quarters#index' => 'pages#start'

  get 'search' => 'search#index'

  resources :profiles, :path_names => {:new => "neu", :edit => "bearbeiten"} do
    member do
      post :assign_moderator
      post :remove_moderator

      post :block
      post :unblock

      get 'note', action: 'edit_note'
      put 'note', action: 'update_note'
    end
  end

  resources :widgets, :path_names => {:new => "neu", :edit => "bearbeiten"}

  devise_for :users, controllers: {
    registrations: 'user_registrations'
  }

  get 'nutzerverwaltung' => "profiles#manage_users", :as => 'manage_users'

  match 'dashboard' => 'pages#dashboard'
  match 'start' => 'pages#start'

  match "/sitemap.xml", :controller => "sitemap", :action => "index"

  match "/rss.xml" => redirect("/feed")


  root :to => "pages#start"

  get '/:slug' => 'pages#show', as: 'static'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
