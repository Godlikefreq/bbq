class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]
  before_action :set_current_user, except: %i[ show ]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t("controllers.users.updated") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
