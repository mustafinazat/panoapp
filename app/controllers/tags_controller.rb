class TagsController < ApplicationController
  def show
  	@tag = Tag.find_by(name: params[:id])
  end

    def destroy
  	@tag = Tag.find_by(name: params[:id])
    @tag.destroy
    respond_to do |format|
      @tags = Tag.all
      format.js
     
    end
  end

      def index
  	@tags = Tag.all
  	
  end


end
