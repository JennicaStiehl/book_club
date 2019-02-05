class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:sort] == 'oldest'
      binding.pry
      @reviews = @user.sort_by_oldest
    elsif params[:sort] == 'newest'
      @reviews = @user.sort_by_newest
    else
      @reviews = @user.reviews
    end
  end
end
