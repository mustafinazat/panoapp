class PanoramasController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  def index
 @panoramas = Panorama.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @panorama = Panorama.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @panorama }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
   # @post = Post.find(params[:id])
    #@panorama = @post.panoramas.build

    #respond_to do |format|
    #  format.html # new.html.erb
     # format.json { render json: @panorama }
   # end
  end

  # GET /pictures/1/edit
  def edit
    #@gallery = Gallery.find(params[:gallery_id])

   # @panorama = Panorama.find(params[:id])
    # @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
   # @panorama = Panorama.new(params[:picture])

   # if @panorama.save
    #  respond_to do |format|
     #   format.html {
      #    render :json => [@panorama.to_jq_upload].to_json,
        #  :content_type => 'text/html',
         # :layout => false
       # }
       # format.json {
        #  render :json => [@panorama.to_jq_upload].to_json
        #}
     # end
  #  else
    #  render :json => [{:error => "custom_failure"}], :status => 304
   # end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

   # @post = Post.find(params[:id])

   # @panorama = @post.panoramas.find(params[:id])

    #respond_to do |format|
      #if @panorama.update_attributes(panorama_params)
      #  format.html { redirect_to post_path(@post), notice: 'Picture was successfully updated.' }
      #  format.json { head :no_content }
     # else
       # format.html { render action: "edit" }
       # format.json { render json: @panorama.errors, status: :unprocessable_entity }
     # end
   # end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    #@gallery = Gallery.find(params[:gallery_id])
    #@picture = @gallery.pictures.find(params[:id])
    @panorama = Panorama.find(params[:id])
    @panorama.destroy

    respond_to do |format|
      format.html { redirect_to  request.referrer }
      format.js
    end
  end

  private

  def panorama_params
    params.require(:panorama).permit(:post_id, :image)
  end






end
