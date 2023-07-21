class UsersController < ApplicationController
  def new
    @user = User.new
    # Render the user registration form
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # User successfully created
      flash[:notice] = "User registered successfully!"
      redirect_to ads_path
    else
      # Failed to create user, render the registration form again
      flash[:alert] = "Error while creating user. Check server logs."
      puts flash[:alert]
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password, :isModerator)
  end
end