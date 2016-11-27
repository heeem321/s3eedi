class AddPledgedAmountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pledged_amount, :integer, default: 0, after: :amount
  end
end
