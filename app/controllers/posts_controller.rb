class PostsController < ApplicationController
  before_action :new_post, only: [:index, :edit]
  before_action :order_post, only: [:index, :edit]
  before_action :find_post, only: [:destroy, :update]
  before_action :new_comment, only: [:index]

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |f|
        f.js {}
      end
    else
      order_post
      render :index
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post_edit = find_post
    render :index
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path(anchor: "post_number_#{@post.id}")
    else
      @post_edit = find_post
      order_post
      new_post
      render :index
    end
  end

  private

  def new_comment
    @comment = Comment.new
  end

  def new_post
    @post = Post.new
  end

  def order_post
    @posts = Post.all.order(created_at: :desc)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.required(:post).permit(:user_id, :title, :content)
  end
end
