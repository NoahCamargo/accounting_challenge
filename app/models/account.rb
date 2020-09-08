class Account < ApplicationRecord
  validates_presence_of :name, :opening_balance

  validates_uniqueness_of :id
end
