class BooksController < ApplicationController
  skip_before_action :confirm_logged_in

  before_action :find_authors, only: [:new, :create, :edit, :update]
  before_action :set_book_count, only: [:index, :delete]

  def index
    # logger.debug("**_ Testing the logger. _***")
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "New Book saved to the database"
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(book_params)
      flash[:notice] = "New Book updated to the database"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    flash[:notice] = "Book - #{@book.title} - has been removed from the database."
    redirect_to(books_path)
  end

  private

  def book_params
    params.require(:book).permit(:title, :year, :author_id, :book_type)
  end

  def find_authors
    @authors = Author.sorted
  end

  def set_book_count
    @book_count = Book.all.size
    if params[:action] == 'delete'
      @book_count -= 1
    end
  end
end
