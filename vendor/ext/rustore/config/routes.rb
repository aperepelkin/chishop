Rails.application.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :advanced_reports, :only => [:index, :show] do
      collection do
        get :inventory
      end
    end
  end
end
