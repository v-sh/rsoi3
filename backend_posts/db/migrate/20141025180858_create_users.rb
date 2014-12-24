class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :displayName
      t.string :gplus_url
      t.string :image_url
      t.string :about_me
      t.string :gender
      t.integer :gplus_id

      t.timestamps
    end
  end
end
