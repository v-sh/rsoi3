class CreateOauthCodes < ActiveRecord::Migration
  def change
    create_table :oauth_codes do |t|
      t.string :code
      t.string :token
      t.integer :account_app_permission_id
      t.timestamps
    end
  end
end
