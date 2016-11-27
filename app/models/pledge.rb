class Pledge < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :amount, numericality: { integer_only: true, greater_than: 0 }
  after_commit do |pledge|
    pledge.post.update_columns pledged_amount: pledge.post.pledges.sum(:amount)
  end
end
