ActionController::Routing::Routes.draw do |map|
  map.resources :reports

  map.resources :photos


  map.resources :comments

  map.resources :appointments


  map.resources :timeslots

  map.resources :beds

  map.resources :rooms

  map.resources :users, :collection => {:admin_registration_form => :get, :doctor_registration_form => :get, :patient_registration_form => :get}

  map.resources :doctors, :collection => {:doctor_list => :get}

  map.resources :patients, :collection => {:patient_list => :get}



  # map.resources :doctors
  # The priority is based upon order of creation: first created -> highest priority.
  # Sample of regular route:

     # map.connect 'doctors/index', :controller => 'doctors', :action => 'index'
  # map.connect 'admitted_records/new_record', :controller => 'admitted_records', :action => 'new_record'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "sessions"
end
