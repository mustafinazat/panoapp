class PagesController < ApplicationController
	def about
		 @first_pano = Panorama.first;
	end
		def faq
	end
	
end
