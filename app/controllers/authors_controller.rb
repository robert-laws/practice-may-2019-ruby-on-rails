class AuthorsController < ApplicationController
  def index
    @authors = Author.sorted
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    # @author = Author.new({age: 20})
    @author = Author.new
  end

  def create
    # instantiate a new object using form parameters
    @author = Author.new(author_params)

    # save the object
    if @author.save
      # if save succeeds, redirect to the index page
      flash[:notice] = "The author was created successfully."
      redirect_to(authors_path)
    else
      # if save fails, re-display the form so the user can correct errors
      render('new')
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])

    if @author.update_attributes(author_params)
      flash[:notice] = "The author was updated successfully."
      redirect_to author_path(@author)
    else
      render('edit')
    end
  end

  def delete
    @author = Author.find(params[:id])
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    flash[:notice] = "The author '#{@author.name}' was destroyed successfully."
    redirect_to(authors_path)
  end

  private

  def author_params
    params.require(:author).permit(:name, :age)
  end
end
