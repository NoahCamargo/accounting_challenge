Rails.application.routes.draw do
  match '*path',
        controller: 'application',
        action: 'options',
        constraints: { method: 'OPTIONS' },
        via: [:options]

  resources :accounts, only: :create
end
