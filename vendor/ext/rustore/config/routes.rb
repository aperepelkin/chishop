Rails.application.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :advanced_reports, :only => [:index, :show] do
      collection do
        get :inventory
      end
    end
    resources :orders do
      member do
        get :deliver
        post :deliver
        get :delivered
        post :delivered
      end
    end
    resources :promotions do
      member do
        post :replicate
        get :replicate
      end
    end
  end
end
