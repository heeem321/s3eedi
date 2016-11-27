class Post < ActiveRecord::Base
  has_attached_file :image, styles: {
      large: "600x600>",
      medium: "300x300>",
      thumb: "150x150#"
    },
    default_url: -> (attachment) {
      ActionController::Base.helpers.asset_path('no-image.png')
    }

  belongs_to :user
  has_many :pledges

  validates :amount, numericality: { integer_only: true, greater_than: 0 }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_presence_of :title, :description, :amount, :user
end
