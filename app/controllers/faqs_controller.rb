class FaqsController < ApplicationController
def index
    @faqs = Faq.all
    @faq = Faq.new
  end

	def create
  @faq = Faq.new(faq_params)
 
  respond_to do |format|
    if @faq.save
      format.html { redirect_to @faq, notice: 'faq was successfully created.' }
      format.js
      format.json { render json: @faq, status: :created, location: @faq}
    else
      format.html { render action: "new" }
      format.json { render json: @faq.errors, status: :unprocessable_entity }
    end
  end
end



  def destroy
  	@faq = Faq.find(params[:id])
    @faq.destroy
    respond_to do |format|
      @faqs = Faq.all
      format.js
     
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_params
      params.require(:faq).permit(:question, :answer)
    end



end
