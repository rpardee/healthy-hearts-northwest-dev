Rails.application.routes.draw do

  resources :manager_notes
  devise_for :partners
  devise_scope :partners do
    get  'partners/admin_new' => 'partners#admin_new'
    post 'partners/admin_create' => 'partners#admin_create'
  end

  resource :mains, only: :index
  get 'practice_survey_thanks', to: 'mains#practice_survey_thanks'
  get 'admin_area', to: 'mains#admin_area'
  get 'supervisor_area', to: 'mains#supervisor_area'
  # 'dashboardy' things
  get 'practice_contacts', to: 'mains#practice_contacts'
  get 'practice_progress', to: 'mains#practice_progress'
  get 'practice_lifetime/:id', to: 'mains#practice_lifetime', as: 'practice_lifetime'

  resources :sites do
    resources :partners
  end
  resources :partners do
    resources :events
    resources :practices
    get 'list', on: :collection
    get 'assign_practice', on: :member
  end
  resources :practices do
    resources :events
    resources :personnels
  end
  resources :coach_practices do
    resources :ivcontacts
    resources :coach_items
    get 'list', on: :member
  end
  resources :ivcontacts do
    resources :high_leverage_change_tests
  end
  resources :coach_assignments, only: [ :index, :edit, :update ]
  resources :events
  resources :personnels
  resources :practice_surveys
  resources :high_leverage_change_tests
  resources :coach_items
  resources :dropouts, only: [ :index, :edit, :update ]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'mains#index'
  as :partner do
    get 'partners', :to => 'partners#show', :as => :partner_root
  end

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
