# frozen_string_literal: true

# bundle exec rspec spec/models/bank_transaction_spec.rb

RSpec.describe BankTransaction, type: :model do

  let(:create_account!) do
    Account.create!(name: Faker::Name.name, opening_balance: 100000)
  end

  it 'Without params' do
    expect(BankTransaction.new).to_not be_valid
    expect(BankTransaction.new(source_account_id: rand(1000))).to_not be_valid
    expect(BankTransaction.new(destination_account_id: rand(1000))).to_not be_valid
    expect(BankTransaction.new(amount: rand(1000))).to_not be_valid
  end

  it 'Same account' do
    create_account!

    expect(BankTransaction.new(source_account_id: 1, destination_account_id: 1, amount: 10000)).to_not be_valid
  end

  it 'Create object' do
    create_account!

    expect(BankTransaction.new(source_account_id: 1, destination_account_id: 2, amount: 10000)).to be_valid
  end

  it 'Insufficient Balance' do
    account = Account.first

    bank_transaction = BankTransaction.create!(source_account_id: 1, destination_account_id: 2, amount: account.opening_balance + 1)

    expect(bank_transaction.persisted?).to eq(false)
  end
end
