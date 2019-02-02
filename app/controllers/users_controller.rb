class UsersController < ApplicationController
  def show
    @user = User.first
    if params[:sort] == 'oldest'
      @reviews = @user.sort_by_oldest
    elsif params[:sort] == 'newest'
      @reviews = @user.sort_by_newest
    else
      @reviews = @user.reviews
    end
  end
end
