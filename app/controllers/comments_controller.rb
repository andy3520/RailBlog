class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy, :update]
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
      if params[:images]
        params[:images].each { |image|
          @comment.pictures.create(image: image)
        }
      end
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

  def edit
    @comment_edit = find_comment
    respond_to do |f|
      f.js {}
    end
  end

  def update
    if @comment.update(comment_params)
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

  def destroy
    if @comment.destroy
      respond_to do |f|
        f.js {}
      end
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :cmt, pictures_attributes: [:id, :image, :_destroy])
  end

  def order_comments(page, item_num, list)
    @comments = list.paginate(page: page, per_page: item_num).order(created_at: :desc)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
