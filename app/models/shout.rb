class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true

  # delegate "makes it clear that this is a method that belongs to a relationship (between user and shout)"
  delegate :username, to: :user

  scope :search, ->(term:) { joins("LEFT JOIN text_shouts ON content_type= 'TextShout' AND content_id = text_shouts.id").
      where("text_shouts.body LIKE ?", "%#{term}%") }
end
