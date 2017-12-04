class UsersController < ApplicationController
	def show
@user = User.find(params[:id])
@posts = @user.posts
#@virtualtours = @user.virtualtours
end
end