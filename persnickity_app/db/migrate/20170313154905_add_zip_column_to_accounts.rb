class AddZipColumnToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :zip_code, :integer, limit:5, default: 10001
  end
end
