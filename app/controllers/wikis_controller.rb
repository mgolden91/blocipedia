class WikisController < ApplicationController
  # before_filter :authenticate_user!
  # before_filter :admin_only, :only => :destroy

  def index
    @wikis = Wiki.visible_to(current_user)
    @user = current_user
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.private == nil
      @wiki.private = false
    end
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was created successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def new
    @wiki = Wiki.new
    @user = current_user
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def show
    @wiki = Wiki.find(params[:id])

    unless @wiki.private == false || current_user.role != "standard"
      flash[:alert] = "You must be signed in to view private wikis"
      redirect_to action: :index
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
    # @wiki = Wiki.find(params[:id])
    #
    # if @wiki.destroy
    #   flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
    #   redirect_to action: :index
    # else
    #   flash.now[:alert] = "There was an error deleting the topic."
    #   render :show
    # end
  end

  private
  # def admin_only
  #   unless current_user.admin?
  #     redirect_to action: :show, :alert => "Access denied."
  #   end
  # end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
