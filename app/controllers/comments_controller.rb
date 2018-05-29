class CommentsController < ApplicationController

  @@load = 1
  def index
    @@load = 1
    list_comment = Comment.where(post_id: params[:post_id])
    order_comments(1, 2, list_comment)
    @post_id = params[:post_id]
    respond_to do |f|
      f.js {}
    end
  end

  def more_comment
    @@load += 1
    @post_id = params[:post_id]
    list_comment = Comment.where(post_id: params[:post_id])
    @comments_more = order_comments(@@load, 2, list_comment)
    respond_to do |f|
      f.js {}
    end
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |f|
        f.js {}
      end
    else
      @error = @comment.errors
      respond_to do |f|
        f.js {}
      end
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :cmt)
  end

  def order_comments(page, item_num, list)
    @comments = list.paginate(page: page, per_page: item_num).order(created_at: :desc)
  end
end
