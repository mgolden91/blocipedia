class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def downgrade
    @user = current_user
    @user.role = "standard"
    if @user.save!
      flash[:notice] = "Successfully downgraded account"
    else
      flash[:error] = "Error please try again."
    end
    redirect_to user_path(current_user)
  end

  def update
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

end
