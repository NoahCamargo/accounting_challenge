class JwtStorage < ApplicationRecord
  validates_presence_of :header, :payload, :verify_signature, :account_id
  validates_uniqueness_of :verify_signature

  after_commit :flush_cache

  def self.generate_token! payload, account_id
    token = JWT.encode(payload, JWT_STORAGE_KEY, 'HS256').split('.')

    Rails.cache.write(jwt_secret_key(token.last), true, expires_in: 1.hours)
    JwtStorage.create(header: token[0], payload: token[1], verify_signature: token[2], account_id: account_id)

    token.join('.')
  end

  def self.exist? verify_signature
    cache_exist = Rails.cache.exist?(jwt_secret_key(verify_signature))

    return false unless cache_exist || JwtStorage.exists?(verify_signature: verify_signature)

    Rails.cache.write(jwt_secret_key(verify_signature), true, expires_in: 1.hours)
  end

  def self.remove! verify_signature
    JwtStorage.find_by_verify_signature(verify_signature)&.destroy

    Rails.cache.delete(jwt_secret_key(verify_signature))
  end

  def self.decode token
    JWT.decode(token, JWT_STORAGE_KEY, true, { algorithm: 'HS256' })
  end

  def self.cached_token account_id
    Rails.cache.fetch(jwt_account_token(account_id), expires_in: 1.hours) do
      where(account_id: account_id).limit(1).pluck(
        :header, :payload, :verify_signature
      ).first&.join('.')
    end
  end

  def self.clean_tokens! account_id
    where(account_id: account_id).destroy_all
  end

  def self.jwt_secret_key verify_signature
    "jwt_secret_key_#{verify_signature}"
  end

  def self.jwt_account_token account_id
    "jwt_token_account_id_#{account_id}"
  end

  private

  def flush_cache
    Rails.cache.delete(self.class.jwt_secret_key(verify_signature))
    Rails.cache.delete(self.class.jwt_account_token(account_id))
  end
end
