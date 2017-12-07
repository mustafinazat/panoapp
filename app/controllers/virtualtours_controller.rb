class VirtualtoursController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_virtualtour, only: [:show, :edit, :update, :destroy]

  # GET /virtualtours
  # GET /virtualtours.json
  def index
  @virtualtours = Virtualtour.paginate(page: params[:page], per_page: 6).order("created_at desc").search(params[:search])    
  end

  # GET /virtualtours/1
  # GET /virtualtours/1.json
  def show
    @panoramas = @virtualtour.panoramas
    @connections = @virtualtour.connections.split("/");
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @virtualtour }
    end

  end

  # GET /virtualtours/new
  def new
    @virtualtour = Virtualtour.new
  end

  # GET /virtualtours/1/edit
  def edit
  end

  # POST /virtualtours
  # POST /virtualtours.json
  def create
    @virtualtour = current_user.virtualtours.new(virtualtour_params)

    respond_to do |format|
      if @virtualtour.save

        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @virtualtour.panoramas.create(image: image)
          }
        end

        format.html { redirect_to @virtualtour, notice: 'Virtualtour was successfully created.' }
        format.json { render :show, status: :created, location: @virtualtour }
      else
        format.html { render :new }
        format.json { render json: @virtualtour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /virtualtours/1
  # PATCH/PUT /virtualtours/1.json
  def update
    respond_to do |format|
      if @virtualtour.update(virtualtour_params)



        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @virtualtour.panoramas.create(image: image)
          }
        end


        format.html { redirect_to @virtualtour, notice: 'Virtualtour was successfully updated.' }
        format.json { render :show, status: :ok, location: @virtualtour }
      else
        format.html { render :edit }
        format.json { render json: @virtualtour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /virtualtours/1
  # DELETE /virtualtours/1.json
  def destroy
    @virtualtour.destroy
    respond_to do |format|
      format.html { redirect_to virtualtours_url, notice: 'Virtualtour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_virtualtour
      @virtualtour = Virtualtour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def virtualtour_params
      params.require(:virtualtour).permit(:title, :description, :connections)
    end
end
