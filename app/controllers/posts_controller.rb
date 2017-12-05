class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 6).order("created_at desc").search(params[:search])    



  end
  # GET /posts/1
  # GET /posts/1.json
  def show
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
  # GET /posts/new
  def new
    @post = Post.new
  end
  # GET /posts/1/edit
  def edit
    authorize @post;
  end
  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save

        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @post.panoramas.create(image: image)
          }
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
     authorize @post, :update?
    respond_to do |format|
      if @post.update(post_params)


         if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @post.panoramas.create(image: image)
          }
        end

        
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :vk_owner_id, :vk_album_id)
    end
end
