class BooksController < ApplicationController

  before_action :set_newbook, only: [:index, :show]

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.page(params[:page])
    @user = current_user
  end

  # 投稿データの保存
  def create
    @newbook = Book.new(book_params)
      @newbook.user = current_user
      if @newbook.save
        flash[:notice]="You have creatad book successfully."
        redirect_to book_path(@newbook)
      else
        @user = current_user
        @books = Book.page(params[:page])
        render :index
      end
  end

  def show
    @user = @book.user
  end

  def edit
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

# book編集データ更新
  def update
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  # book削除
  def destroy
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

   # 投稿データのストロングパラメータ
  private

  def set_newbook
    @newbook = Book.new
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end