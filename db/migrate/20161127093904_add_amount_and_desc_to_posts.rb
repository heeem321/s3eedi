class AddAmountAndDescToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :text
    add_column :posts, :amount, :integer, default: 0
  end
end
