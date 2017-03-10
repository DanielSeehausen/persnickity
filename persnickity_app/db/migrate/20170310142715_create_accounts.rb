class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password_digest
      t.varchar{320} :email

      t.timestamps
    end
  end
end
