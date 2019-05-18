Rails.application.routes.draw do
  ## simple match route
  get 'demo/index', to: 'demo#index'
  # match "demo/index", to: "demo#index", via: :get

  ## default route structure
  # :controller/:action/:id
  # example: GET /students/edit/52 -> StudentsController, edit action, id = 52
  # get ':controller(/:action(/:id))'

  ## route route -> home page for application
  root 'demo#index'
end
