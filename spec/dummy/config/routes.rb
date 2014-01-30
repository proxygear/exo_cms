Rails.application.routes.draw do

  scope module: :exo do
    namespace :admin, module: 'admin' do
      resources :customs
    end
  end

  namespace :admin, module: 'my_app' do
    resources :site_customs
  end

  mount Exo::Engine => "/"
end
