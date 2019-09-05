class User < ApplicationRecord
  include Clearance::User

  validates :username, presence: true, uniqueness: true

  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout

  # table to follow the relationship where the user table points to itself.
  # so when we use the foreign key we don't want to use the user_id but instead the follower_id
  has_many :followered_user_relationships,
           foreign_key: :follower_id,
           class_name: "FollowingRelationship",
           dependent: :destroy
  has_many :followed_users, through: :followered_user_relationships

  # since this is a different direction we need to reference a different foreign key to find the followers.
  has_many :follower_relationships,
           foreign_key: :followed_user_id,
           class_name: "FollowingRelationship",
           dependent: :destroy
  has_many :followers, through: :follower_relationships

  def timeline_shouts
    Shout.where(user_id: followed_user_ids + [id])
  end

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def following?(user)
    followed_user_ids.include?(user.id)
  end

  def like(shout)
    liked_shouts << shout
  end

  def unlike(shout)
    liked_shouts.destroy(shout)
  end

  def liked?(shout)
    liked_shout_ids.include?(shout.id)
  end

  def to_param
    username
  end
end
