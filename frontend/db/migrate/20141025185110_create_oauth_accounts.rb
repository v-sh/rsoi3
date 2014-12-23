class CreateOauthAccounts < ActiveRecord::Migration
  def change
    create_table :oauth_accounts do |t|
      t.string :email
      t.string :telephone
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end
end
