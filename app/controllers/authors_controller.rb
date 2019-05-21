class AuthorsController < ApplicationController
  def index
    @authors = Author.sorted
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end
