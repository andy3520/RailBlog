class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.all.order(created_at: :desc)
      render 'posts/index'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def edit
    @post_edit = Post.find(params[:id])
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    render 'posts/index'
  end

  def update
    post = Post.find(params[:post][:id_post])
    if post.update(post_params)
      redirect_to posts_path( anchor: "post_number_#{post.id}")
    else
      @post_edit = Post.find(params[:id])
      @post = Post.new
      @posts = Post.all.order(created_at: :desc)
      render 'posts/index'
    end
  end

  def post_params
    params.required(:post).permit(:user_id, :title, :content)
  end
end
