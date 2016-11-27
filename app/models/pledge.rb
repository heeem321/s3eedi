class Pledge < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :amount, numericality: { integer_only: true, greater_than: 0 }
end
