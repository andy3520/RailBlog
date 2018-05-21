class CommentsController < ApplicationController

  def index
    respond_to do |f|
      f.html
      f.js
    end
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |f|
        f.html { redirect_to posts_path, flash: 'Comment was successfully created.' }
        f.js {}
      end
    else

    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :cmt)
  end
end
