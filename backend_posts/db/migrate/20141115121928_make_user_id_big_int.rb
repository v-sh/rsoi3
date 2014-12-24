class MakeUserIdBigInt < ActiveRecord::Migration
  def up
    change_column :users, :gplus_id, :string
  end

  def down
    change_column :users, :gplus_id, :integer
  end
end
