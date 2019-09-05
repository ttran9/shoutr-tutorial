class Like < ApplicationRecord
  belongs_to :user
  belongs_to :shout

  # ensure that there is a unique pair of user id and shout id.
  validates :user_id, uniqueness: { scope: :shout_id }
end
