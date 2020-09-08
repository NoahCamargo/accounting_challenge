class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :account_id, index: true
      t.integer :opening_balance

      t.string :name

      t.timestamps
    end
  end
end
