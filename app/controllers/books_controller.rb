class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end

  def new
    @book = Book.new 
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all  
      render :index  
    end
  end 

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  end
  
  def edit
  end 
  
  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      flash.now[:alert] = 'There was an error updating the book.'
      render :edit
    end 
  end
  
  def destroy
    if @book.destroy
      redirect_to books_path, notice: 'Book was successfully deleted.'
    else
      redirect_to books_path, alert: 'Failed to delete the book.'
    end
  end
  
  private 
  
  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found."
  end

  def book_params
    params.require(:book).permit(:title, :body)  
  end
end
