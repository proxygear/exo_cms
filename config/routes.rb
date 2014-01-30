Exo::Engine.routes.draw do
  if ['development', 'test'].include?(Rails.env)
    _site_grid_fs_path = '/grid_fs/exo/:site_slug_id/'
    get "#{_site_grid_fs_path}/resources/:resource_slug_id/:item_slug_id/:field_slug_id/*file_name", to: 'gridfs#item_asset'
    get "#{_site_grid_fs_path}/:id/*file_name", to: 'gridfs#asset'
  end

  root 'pages#serve_page', route_path: '/'

  # get '/admin', to: 'admin/site#show', as: 'contributor_root'
  # 
  # get '/admin', to: 'admin/site#show', as: 'admin_contributor_root'
    
  put '/admin/pages/blocks', to: 'admin/ckeditor_blocks#update'

  devise_for(
    :contributors,
    class_name: "Exo::Contributor", module: :devise, :path => '/admin',
    controllers: {
      sessions: "exo/admin/sessions"
    }
  )

  namespace :admin, module: 'admin' do
    root 'site#show', route_path: '/'
    # put '/pages/blocks', to: 'ckeditor_blocks#update'
    #devise_for :contributors, class_name: "Exo::Contributor", module: :devise, :path => '/'

    resources :contributors
    resources :settings
    resources :assets
    resources :routes, only: [:index, :show, :edit, :picture] do
      resources :settings
    end
    resources :resources, only: [:index, :show] do
      resources :items, except: :index
    end
    resources :ckeditor_assets, only: :create
  end

  get '/*route_path' => 'pages#serve_page'
end
