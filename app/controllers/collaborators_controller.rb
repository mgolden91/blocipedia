class CollaboratorsController < ApplicationController

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @users = User.all
    @selectcollaborator = User.all.reject {|u| @wiki.users.include?(u) || current_user == (u) || @wiki.user_id == (u.id)}
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])

    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator created."
    else
      flash[:alert] = "Error adding Collaborator try again."
    end
    redirect_to wiki_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user.username}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the topic."
      redirect_to wikis_path
    end
  end


  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
