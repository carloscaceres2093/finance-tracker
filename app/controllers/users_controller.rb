class UsersController < ApplicationController
	def my_portfolio
		@user = current_user
		@user_stocks = current_user.stocks
	end
	def my_friends
		@friendships = current_user.friends
	end
	def search
		if params[:search_param].blank? #To know if the search is empty
			flash.now[:danger]="You have entered on empty search string"
		else
			@users = User.search(params[:search_param])
			@users = current_user.except_current_user(@users)
			flash.now[:danger]='No users match this search criteria' if @users.blank? # To know if the search users criteria is good
	    end
	    respond_to do |format|
	    	format.js{ render partial: 'friends/result'}
	   	end
	end
	def add_friend
		@friend = User.find(params[:friend])
		current_user.friendship.build(friend_id:@friend.id)
		if current_user.save
			flash[:success] = "Friend was successfully added"
		else
			flash[:danger] = "There was something wrong with the friend request"
		end
		redirect_to my_friends_path
	end
	def show
		@user = User.find(params[:id])
		@user_stocks = @user.stocks
	end
end