Rails.application.routes.draw do
  match '*path',
        controller: 'application',
        action: 'options',
        constraints: { method: 'OPTIONS' },
        via: [:options]

  resources :accounts, only: :create do 
    collection do
      get :check_balance, path: 'check-balance'

      post :bank_transaction, path: 'bank-transaction'
    end
  end
end
