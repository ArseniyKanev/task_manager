Rails.application.routes.draw do

  root 'welcome#index'

  scope module: 'auth' do
    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection, as: :destroy
    end
    resources :users, only: [:new, :create]
  end

  scope module: 'user' do
    resources :tasks do
      member do
        put :start
        put :finish
      end
    end
  end

end

