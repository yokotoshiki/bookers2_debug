class BookCommentsController < ApplicationController

def create
  @book = Book.find(params[:book_id])
  @comment = current_user.book_comments.new(book_comment_params)
  @comment.book = @book
  if@comment.save
    redirect_back(fallback_location: root_path)
  else
    @book_new = Book.new
    @book_comment = BookComment.new
    render template:"books/show"
  end
end

def destroy
     if
      BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
      redirect_back(fallback_location: root_path)
    end
end

private
	def book_comment_params
	  params.require(:book_comment).permit(:comment, :book_id, :user_id)
	end
end