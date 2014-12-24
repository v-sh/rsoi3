class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :key
      t.string :data

      t.timestamps
    end
  end
end
