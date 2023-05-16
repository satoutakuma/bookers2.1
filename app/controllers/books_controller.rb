class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
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
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
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
end
