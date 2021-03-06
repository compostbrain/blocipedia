class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])

    # authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = 'Wiki was saved.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    @wiki.collaborators = []
    collaborators = params[:collaborators]
    collaborators.present? && collaborators.each do |user_id|
      WikiCollaborator.create!(user_id: user_id, wiki_id: @wiki.id)
      #@wiki.collaborators << User.find(user_id)
    end
    authorize @wiki

    if @wiki.save
      flash[:notice] = 'Wiki was updated.'
      redirect_to [@wiki]
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash.now[:alert] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id, collaborators: :[])
  end


end
