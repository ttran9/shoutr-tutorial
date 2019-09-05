class UsersController < Clearance::UsersController
  # https://github.com/thoughtbot/clearance/blob/master/app/controllers/clearance/users_controller.rb
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(username: params[:id])
    @timeline = Timeline.new([@user])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
