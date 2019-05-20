Rails.application.routes.draw do
  ## root route -> home page for application
  root 'demo#index'

  resources :authors do
    member do
      get :delete
    end
  end

  resources :books, only: [:index, :show] 

  ## simple match route
  get 'demo/', to: 'demo#index'
  get 'demo/index', to: 'demo#index'
  # match "demo/index", to: "demo#index", via: :get

  ## default route structure
  # :controller/:action/:id
  # example: GET /students/edit/52 -> StudentsController, edit action, id = 52
  # get ':controller(/:action(/:id))'



  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/lynda'
end
