class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Информация о пользователе обновлена." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
