# frozen_string_literal: true

module Helpers

  def authorization_account!(account, payload = { account_id: account.id })
    {
      'Authorization' => 'JWT ' + JwtStorage.generate_token!(payload, account.id)
    }
  end

end
