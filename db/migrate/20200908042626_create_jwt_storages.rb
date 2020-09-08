class CreateJwtStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :jwt_storages do |t|
      t.string :header
      t.string :payload
      t.string :verify_signature, index: true

      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
