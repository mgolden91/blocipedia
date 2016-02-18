class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def downgrade
    @user = current_user
    @user.role = "standard"
    @wikidgrade = Wiki.all
    @wikidgrade.each do |f|
      if f.user_id == @user.id
        f.private = false
        f.save!
      end
    end
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
