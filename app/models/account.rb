class Account < ApplicationRecord
  has_many :debits, class_name: 'BankTransaction', foreign_key: :source_account_id
  has_many :credits, class_name: 'BankTransaction', foreign_key: :destination_account_id

  validates_presence_of :name, :opening_balance

  validates_uniqueness_of :id

  after_commit :flush_cache

  def get_balance
    (credits.sum(:amount) - debits.sum(:amount)) + opening_balance
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id], expires_in: 10.minutes) do
      find(id)
    end
  end

  private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
