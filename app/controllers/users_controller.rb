class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @books = @user.books
    @book = Book.new
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      render :new
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
  end
  

  def edit
    @user = User.find(params[:id])  
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])  
    if @user.update(user_params)    
       redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
       render :edit  
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
