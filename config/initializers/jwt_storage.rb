# frozen_string_literal: true

jwt_storage_key = Rails.application.credentials.secret_key_base

if !Rails.env.production? && jwt_storage_key.nil?
  jwt_storage_key = 'ad5c3a2c8de501db981d612b60f04076ea348eb45938007f033'
end

JWT_STORAGE_KEY = jwt_storage_key