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
end
