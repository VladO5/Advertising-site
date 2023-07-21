class SessionsController < ApplicationController
  def new
    # Render the login form
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.password == params[:session][:password]
      log_in(user)
      redirect_to ads_path, notice: "Logged in successfully!"
    else
      flash[:alert] = "Invalid email or password"
      puts flash[:alert]
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to ads_path, notice: "Logged out successfully!"
  end
end
