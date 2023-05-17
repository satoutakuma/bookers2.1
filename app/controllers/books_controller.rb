class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @users = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      flash[:notice] = "error Book was not successfully created."
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      flash[:notice] = "error Book was not successfully updated."
      @books = Book.all
      render :edit
    end
  end
  
  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  	flash[:notice] = "Book was successfully destroyed."
  end
  
  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end
end
