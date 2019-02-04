class ReviewsController < ApplicationController
  def destroy
    Review.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end
end
