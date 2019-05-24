class BooksController < ApplicationController
  def index
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
end
