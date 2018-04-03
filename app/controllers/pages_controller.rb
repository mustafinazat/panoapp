class PagesController < ApplicationController
	before_action :set_page, only: [:show]
  def about
		@aboutpage = Page.where(slug: 'about').take;
	end
	def main
		@posts = Post.order("created_at desc").getopened(current_user).last(3)
		@virtualtours = Virtualtour.order("created_at desc").getopened(current_user).last(3)
	end
	def show
	end
private
# Use callbacks to share common setup or constraints between actions.
 def set_page
	@page = Page.friendly.find(params[:id])
 end

end
