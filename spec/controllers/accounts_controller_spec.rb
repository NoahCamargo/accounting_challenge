# frozen_string_literal: true

# bundle exec rspec spec/controllers/accounts_controller_spec.rb

RSpec.describe AccountsController, type: :controller do

  describe 'POST#create Account' do
    it 'Account creation failed' do
      post :create

      expect(response).not_to be_successful
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it 'Account creation success' do
      post :create, params: { id: 10, name: Faker::Name.name, opening_balance: rand(-1000..1000) }, as: :json

      expect(response).to be_successful

      response_json = JSON.parse(response.body)

      expect(response_json).to have_key('token')
      expect(response_json).to have_key('account_id')
    end
  end

  describe 'POST#bank_transaction Account' do

    before do
      @headers ||= authorization_account!(Account.first)

      request.headers.merge!(@headers)
    end

    it 'Transaction failed' do
      post :bank_transaction

      expect(response).not_to be_successful
      expect(JSON.parse(response.body).length).to eq(3)
    end

    it 'Account creation success' do
      source_account = Account.first
      destination_account = Account.create!(name: Faker::Name.name, opening_balance: 100000)

      source_account.update(opening_balance: 10000)

      params = {
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        amount: 1000
      }

      post :bank_transaction, params: params, as: :json

      expect(response).to be_successful
    end
  end
end
