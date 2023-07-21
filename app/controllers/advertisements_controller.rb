class AdvertisementsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @advertisements = Advertisement.all
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    # Set the user association
    @advertisement.user = current_user

    if @advertisement.save
      redirect_to ads_path, notice: "Advertisement created successfully!"
    else
      render :new
    end
  end

  def edit
    @advertisement = Advertisement.find(params[:id])
  end

  def update
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.update(advertisement_params)
      redirect_to ads_path, notice: "Advertisement updated successfully!"
    else
      render :edit
    end
  end

  def delete
    @advertisement = Advertisement.find(params[:id])
    # Check if the current user is authorized to delete the advertisement
    if current_user && (current_user.isModerator || @advertisement.user == current_user)
      @advertisement.destroy
      redirect_to ads_path, notice: "Advertisement deleted successfully!"
    else
      redirect_to ads_path, alert: "You are not authorized to delete this advertisement."
    end
  end

  private

  def advertisement_params
    params.require(:advertisement).permit(:title, :body, :isApproved)
  end

  def authenticate_user
    redirect_to login_path unless current_user
  end

  def authorize_user
    advertisement = Advertisement.find(params[:id])
    if current_user.nil? || (advertisement.user != current_user && !current_user.isModerator?)
      flash[:alert] = "You don't have permission to perform this action."
      redirect_to ads_path
    end
  end
end
