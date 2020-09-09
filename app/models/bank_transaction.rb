class BankTransaction < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'

  validates :amount, numericality: { greater_than: 0 }

  validate :same_account_validate

  def same_account_validate
    errors.add(:destination_account, 'cannot be the same account') if source_account_id == destination_account_id
  end
end
