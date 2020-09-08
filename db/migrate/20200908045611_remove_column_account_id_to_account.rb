class RemoveColumnAccountIdToAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :account_id
  end
end
