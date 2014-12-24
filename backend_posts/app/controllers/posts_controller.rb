class PostsController < ApplicationController
  def index
    load_posts
    render json: posts
  end

  def show
    load_post
    build_post
    render json: post
  end

  def create
    build_post
    if post.save
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    load_post
    build_post
    if post.save
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    load_post
    post.destroy
    render json: {status: :ok}
  end

  private
  def build_post
    @post ||= posts_scope.build
    @post.attributes = post_params
  end

  def load_post
    @post ||= posts_scope.find(params[:id])
  end

  def load_posts
    @posts ||= posts_scope
    if params[:ids]
      ids = params[:ids].split(",").map{|x| x.to_i}
      @posts = @posts.where(id: ids)
    end
    @posts = @posts.paginate(page: params[:page], per_page: params[:per_page])
  end

  def posts_scope
    Post.all
  end

  def post_params
    post_params = params[:post]
    post_params ? post_params.permit(:text, :user_id) : {}
  end

  def post
    @post
  end

  def posts
    @posts
  end
end
