class AccountsController < ApplicationController
  def create
    account = Account.new(permitted_params)

    return render_json(account.errors.to_h, 400) unless account.save

    token = JwtStorage.generate_token!({ account_id: account.id }, account.id)

    render_json(account_id: account.id, token: token)
  end

  private

  def permitted_params
    params.permit(:id, :name, :opening_balance)
  end
end
