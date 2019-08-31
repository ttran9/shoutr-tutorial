class UsersController < Clearance::UsersController
  # https://github.com/thoughtbot/clearance/blob/master/app/controllers/clearance/users_controller.rb
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
