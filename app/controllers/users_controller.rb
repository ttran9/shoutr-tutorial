class UsersController < Clearance::UsersController
  # https://github.com/thoughtbot/clearance/blob/master/app/controllers/clearance/users_controller.rb
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @shouts = @user.shouts
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
