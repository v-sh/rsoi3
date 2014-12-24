class PostsController < ApplicationController
  require_permission :posts

  helper_method :post
  helper_method :posts
  def index
    load_posts
    respond_to do |format|
      format.html { render }
      format.json { render json: posts}
    end
  end

  def new
    build_post
  end

  def show
    load_post
    build_post
  end

  def create
    build_post
    respond_to do |format|
      if post.save
        format.html { redirect_to post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: post }
      else
        format.html { render :new }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    load_post
    build_post
    respond_to do |format|
      if post.save
        format.html { redirect_to post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: post }
      else
        format.html { render :edit }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    load_post
    post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    @posts ||= posts_scope.load_collection(params.permit(:page, :per_page))
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
