class Account < ApplicationRecord
  validates_presence_of :account_id, :opening_balance

  validates_uniqueness_of :account_id
end
