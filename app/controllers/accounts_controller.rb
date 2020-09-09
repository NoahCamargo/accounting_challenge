class AccountsController < ApplicationController
  before_action :authenticate_account!, except: :create

  def create
    account = Account.new(permitted_params)

    return render_json(account.errors.to_h, 400) unless account.save

    token = JwtStorage.generate_token!({ account_id: account.id }, account.id)

    render_json(account_id: account.id, token: token)
  end

  def check_balance
    account = Account.find_by_id(params[:account_id])

    return render_json({ account_id: I18n.t("errors.messages.not_exist") }, 400) unless account

    token = JwtStorage.generate_token!({ account_id: account.id }, account.id)

    render_json(balance: account.get_balance)
  end

  def bank_transaction
    transaction = BankTransaction.new(permitted_transaction_params)

    return render_json(transaction.errors.to_h, 400) unless transaction.save

    render_json({})
  end

  private

  def permitted_params
    params.permit(:id, :name, :opening_balance)
  end

  def permitted_transaction_params
    params.permit(:source_account_id, :destination_account_id, :amount)
  end
end
