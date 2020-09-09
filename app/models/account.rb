class Account < ApplicationRecord
  has_many :debits, class_name: 'BankTransaction', foreign_key: :source_account_id
  has_many :credits, class_name: 'BankTransaction', foreign_key: :destination_account_id

  validates_presence_of :name, :opening_balance

  validates_uniqueness_of :id

  def get_balance
    (credits.sum(:amount) - debits.sum(:amount)) + opening_balance
  end
end
