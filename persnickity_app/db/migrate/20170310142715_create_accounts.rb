class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password_digest
      t.string :email, limit: 320

      t.timestamps
    end
  end
end
