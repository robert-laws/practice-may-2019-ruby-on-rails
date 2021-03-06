Rails.application.routes.draw do
  # root route -> home page for application
  root 'demo#index'
  
  get 'admin', to: 'access#menu'
  get 'access/menu'
  get 'login', to: 'access#login', as: 'login'
  post 'access/attempt_login'
  get 'access/logout'

  resources :subjects do
    member do
      get :delete
    end
  end

  resources :authors do
    member do
      get :delete
    end
  end

  resources :books do
    member do
      get :delete
    end
  end

  resources :site_users, except: [:show] do
    member do
      get :delete
    end
  end

  ## simple match route
  get 'demo/', to: 'demo#index'
  get 'demo/index', to: 'demo#index'
  # match "demo/index", to: "demo#index", via: :get

  ## default route structure
  # :controller/:action/:id
  # example: GET /students/edit/52 -> StudentsController, edit action, id = 52
  # get ':controller(/:action(/:id))'

  resources :users, only: [:index, :show]
  get '/register', to: "users#new", as: 'register'

  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/lynda'
  get 'demo/escape_output'
end