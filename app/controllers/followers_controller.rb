class FollowersController < ApplicationController
  def index
    @user = find_user
    @followers = @user.followers
  end

  private
  def find_user
    # user_id this time b/c we're using a nested resource not a member route.
    @_user ||= User.find_by(username: params[:user_id])
  end

end
