class SessionsController < Clearance::SessionsController
  private

  def authenticate(_)
    super(session_params)
  end

  def session_params
    { session: session_params_with_email }
  end

  def session_params_with_email
    params.
        require(:session).
        permit(:password).
        merge(email: user.email)
  end

  def user
    # it is possible user doesn't exist so we need to return a guest object.
    User.where(email: email_or_username).or(User.where(username: email_or_username)).first || Guest.new
  end

  def email_or_username
    params[:session][:email_or_username]
  end
end
