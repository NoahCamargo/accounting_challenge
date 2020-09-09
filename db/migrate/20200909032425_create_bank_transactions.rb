class CreateBankTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_transactions do |t|
      t.references :source_account, foreign_key: { to_table: :accounts }
      t.references :destination_account, foreign_key: { to_table: :accounts }

      t.integer :amount

      t.timestamps
    end
  end
end
