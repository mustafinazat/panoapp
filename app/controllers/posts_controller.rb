class PostsController < ApplicationController

  require 'flickraw'

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
     @posts = Post.paginate(page: params[:page], per_page: 2).order("created_at desc").search(params[:search]).getopened(current_user)
  end
  # GET /posts/1
  # GET /posts/1.json
  def show

  end
  # GET /posts/new
  def new
    @post = Post.new
  end
  # GET /posts/1/edit
  def edit
    authorize @post;
  end


  def userposts
    @user = User.friendly.find(params[:user_id]);
    @posts = @user.posts.paginate(page: params[:page], per_page: 9).order("created_at desc").getopened(current_user)
  end


  # POST /posts
  # POST /posts.json
  def create

    @post = current_user.posts.new(post_params)

    respond_to do |format|


      if params[:images] || !params[:post][:vk_album_id].empty? ||!params[:post][:flickr_album_id].empty?
        begin

          if @post.save

        if !params[:post][:vk_album_id].empty?
              # The magic is here ;)
              vk = VkontakteApi::Client.new(session[:token])

              @photos = vk.photos.get(owner_id: params[:post][:vk_owner_id], album_id: params[:post][:vk_album_id], version: "5.73")
              @photos.each { |image|

                @post.panoramas.create(image_file_name: image.src_xxxbig, image_file_name_thumb: image.src_xbig )
              }

        elsif !params[:post][:flickr_album_id].empty?

              FlickRaw.api_key = ''
              FlickRaw.shared_secret = ''

              @photosets = flickr.photosets.getPhotos(photoset_id: params[:post][:flickr_album_id]).photo.map do |photo|
                flickr.photos.getSizes(photo_id: photo.id).map do |size|
                  size.source
                end
              end
              @photosets.each do |image|
              @post.panoramas.create(image_file_name: image.last, image_file_name_thumb: image[6] )
end
              else

              if params[:images]
                # The magic is here ;)
                params[:images].each { |image|
                  @post.panoramas.create(image: image)
                }
              end
            end

            format.html { redirect_to @post, notice: 'Пост создан' }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }

          end #if post save


        rescue
          flash[:alert] = "Проблема с VK или FLICKR (альбом не доступен)"
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end



      else
        flash[:alert] = "Нужны панорамы!!!"
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }

      end

    end #respond do
   end   #def

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
     authorize @post, :update?
    respond_to do |format|

    begin

          if @post.update(post_params)

            if !params[:post][:vk_album_id].empty?
              # The magic is here ;)


              vk = VkontakteApi::Client.new(session[:token])

              @photos = vk.photos.get(owner_id: params[:post][:vk_owner_id], album_id: params[:post][:vk_album_id], version: "5.73");
              @post.panoramas.destroy_all
              @photos.each { |image|

                @post.panoramas.create(image_file_name: image.src_xxxbig, image_file_name_thumb: image.src_xbig )
              }


            elsif !params[:post][:flickr_album_id].empty?

              FlickRaw.api_key = ''
              FlickRaw.shared_secret = ''

              @photosets = flickr.photosets.getPhotos(photoset_id: params[:post][:flickr_album_id]).photo.map do |photo|
                flickr.photos.getSizes(photo_id: photo.id).map do |size|
                  size.source
                end
              end

              @post.panoramas.destroy_all
              @photosets.each do |image|
                @post.panoramas.create(image_file_name: image.last, image_file_name_thumb: image[6] )
              end


            else

              if params[:images]
                # The magic is here ;)
                params[:images].each { |image|
                  @post.panoramas.create(image: image)
                }
              end
            end

            format.html { redirect_to @post, notice: 'Пост изменен' }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :edit }
            format.json { render json: @post.errors, status: :unprocessable_entity }

          end #if post save


        rescue
          flash[:alert] = "Проблема с VK или FLICKR (альбом не доступен)"
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end



    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize @post, :update?
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост удален' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :vk_owner_id, :vk_album_id, :flickr_album_id,:slug, :all_tags, :closed)
    end
end



