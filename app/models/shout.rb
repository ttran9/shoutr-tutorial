class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates :user, presence: true

  # delegate "makes it clear that this is a method that belongs to a relationship (between user and shout)"
  delegate :username, to: :user

  searchable do
    text :content do
      # index our shouts and just search them.
      case content
        when TextShout then content.body
        when PhotoShout then content.image_file_name
      end
    end
  end
end
