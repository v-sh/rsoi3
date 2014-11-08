class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret
      t.timestamps
    end
  end
end
