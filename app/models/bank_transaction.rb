class BankTransaction < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'

  validates :amount, numericality: { greater_than: 0 }

  validate :same_account_validate

  before_save do
    next true if source_account.get_balance - amount >= 0

    errors.add(:source_account, :insufficient_balance)

    raise ActiveRecord::Rollback
  end

  def same_account_validate
    errors.add(:destination_account, :same_account) if source_account_id == destination_account_id
  end
end
