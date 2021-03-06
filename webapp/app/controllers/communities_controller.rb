class CommunitiesController < PagesController
  layout "application"
  
  def index
    if params[:query]
      @pages = Page.communities.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    else
      @pages = Page.communities.where("active = ?", true)
    end

    @pages = @pages.order(:name)

    respond_to do |format|
        format.html { render :index}
        format.json { render json: @pages }
    end
  end

  def typeahead
    @search  = Page.communities.where("name LIKE ? and active = ?", "%#{params[:query]}%", true)
    render json: @search
  end

end
