class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id),notice: 'You have created book successfully.'
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id),notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path,notice: 'You have updated user successfully.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
