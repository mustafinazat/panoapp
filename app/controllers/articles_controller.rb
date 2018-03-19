class ArticlesController < ApplicationController
   before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 6).order("created_at desc").search(params[:search])
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    authorize @article, :create?
  end

  # GET /articles/1/edit
  def edit
    authorize @article;
  end

  # POST /articles
  # POST /articles.json
  def create

    @article = current_user.articles.new(article_params)
    authorize @article, :create?
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Статья создана' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article, :update?
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Статья изменена' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize @article, :create?
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Статья удалена' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
     params.require(:article).permit(:title, :description,:slug, :all_tags, :picture, :shortdesc)
    end
end
