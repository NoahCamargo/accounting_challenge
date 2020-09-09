# frozen_string_literal: true

# bundle exec rspec spec/models/account_spec.rb

RSpec.describe Account, type: :model do

  let(:create_account) do 
    Account.new(id: 1, name: Faker::Name.name, opening_balance: rand(-1000..1000))
  end

  describe 'POST#create Account' do
    it 'Without params' do
      expect(Account.new).to_not be_valid
      expect(Account.new(name: Faker::Name.name)).to_not be_valid
      expect(Account.new(opening_balance: rand(-1000..1000))).to_not be_valid
    end

    it 'Create object with ID' do
      expect(create_account).to be_valid
    end

    it 'Create object without ID' do
      expect(Account.new(name: Faker::Name.name, opening_balance: rand(-1000..1000))).to be_valid
    end

    it 'Duplicate ID' do
      account = create_account

      account.save!

      account = account.dup
      account.id = Account.first.id

      expect(account).to_not be_valid
    end
  end
end
