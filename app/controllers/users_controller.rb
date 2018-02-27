class UsersController < ApplicationController
	def show
@user = User.friendly.find(params[:id])
@posts = @user.posts.order("created_at desc").limit(6)
@virtualtours = @user.virtualtours.order("created_at desc").limit(6)
end
end