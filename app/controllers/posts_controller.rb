class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
     @posts = Post.paginate(page: params[:page], per_page: 9).order("created_at desc").opened.search(params[:search])
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
    @posts = @user.posts.paginate(page: params[:page], per_page: 9).order("created_at desc").opened
  end


  # POST /posts
  # POST /posts.json
  def create

    @post = current_user.posts.new(post_params)

    respond_to do |format|


       if params[:images]


      if @post.save



         if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @post.panoramas.create(image: image)
          }
        end


       format.html { redirect_to @post, notice: 'Пост создан' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }

      end #if post save

       else
         flash[:alert] = "Нужны панорамы"
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

      if @post.update(post_params)
          if params[:images]
            # The magic is here ;)
            params[:images].each { |image|
              @post.panoramas.create(image: image)
            }
          end

        format.html { redirect_to @post, notice: 'Пост был изменен' }
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
    authorize @post, :update?
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост удален.' }
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
      params.require(:post).permit(:title, :description,:slug, :all_tags, :closed)
    end
end



