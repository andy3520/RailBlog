class PostsController < ApplicationController
  before_action :new_post, only: :index
  before_action :find_post, only: [:destroy, :update]
  after_action { flash.discard }
  @@load = 1
  def index
    @@load = 1
    order_post(1,5)
  end

  def load_more
    @@load += 1
    @posts_more = order_post(@@load,5)
    respond_to do |f|
      f.js {}
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if params[:images]
        params[:images].each { |image|
          @post.pictures.create(image: image)
        }
      end
      respond_to do |f|
        f.js {}
      end
    else
      @error = @post.errors
      respond_to do |f|
        f.js {}
      end
    end
  end

  def destroy
    if @post.destroy
      respond_to do |f|
        f.js {}
      end
    end
  end

  def edit
    @post_edit = find_post
    respond_to do |f|
      f.js {}
    end
  end

  def update
    if @post.update(post_params)
      if params[:images]
        params[:images].each { |image|
          @post.pictures.update(image: image)
        }
      end
      respond_to do |f|
        f.js {}
      end
    else
      @error = @post.errors
      respond_to do |f|
        f.js {}
      end
    end
  end

  private

  def new_post
    @post = Post.new
  end

  def order_post(page, item_num)
    @posts = Post.paginate(page: page, per_page: item_num).order(created_at: :desc)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.required(:post).permit(:user_id, :title, :content, pictures_attributes: [:id, :image, :_destroy])
  end
end
