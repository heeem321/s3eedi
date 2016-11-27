class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :user_id, null: false, index: true
      t.integer :post_id, null: false, index: true
      t.integer :amount, default: 0

      t.timestamps null: false
    end
  end
end
