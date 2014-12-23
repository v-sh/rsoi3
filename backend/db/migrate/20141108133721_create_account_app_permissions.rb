class CreateAccountAppPermissions < ActiveRecord::Migration
  def change
    create_table :account_app_permissions do |t|
      t.integer :oauth_account_id
      t.integer :api_application_id
      t.string :permitted_scopes

      t.timestamps
    end
  end
end
