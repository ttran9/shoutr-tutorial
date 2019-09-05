class Timeline
  def initialize(users, scope = Shout)
    # users can be an array of users varying in size from 0 to many.
    @users = users
    @scope = scope
  end

  def shouts
    scope.
        where(user_id: users).
        order(created_at: :desc)
  end

  def to_partial_path
    "timelines/timeline"
  end

  private

  attr_reader :users, :scope
end