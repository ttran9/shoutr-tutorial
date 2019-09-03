class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true

  # https://api.rubyonrails.org/
  # search for reorder it is necessary to override the below default scope.
  default_scope { order(created_at: :desc) }

  # delegate "makes it clear that this is a method that belongs to a relationship (between user and shout)"
  delegate :username, to: :user
end
