class UsersController < Clearance::UsersController
  # https://github.com/thoughtbot/clearance/blob/master/app/controllers/clearance/users_controller.rb
  def new
    @user = User.new
    render template: "users/new"
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
