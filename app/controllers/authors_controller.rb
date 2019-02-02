class AuthorsController < ApplicationController
  def show
    @author = Author.first
  end
end
