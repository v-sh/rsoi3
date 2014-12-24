class UsersController < ApplicationController
  def index
    load_users
    render json: users
  end

  def show
    load_user
    render json: user
  end

  def create
    build_user
    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    load_user
    build_user
    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    load_user
    user.destroy
    render json: {status: :ok}
  end

  def count
    count = user_scope.count
    respond_to do |format|
      format.html { render text: "#{count}" }
      format.json { render json: {count: count}}
    end
  end

  private
  def load_user
    @user ||= user_scope.find(params[:id])
  end

  def load_users
    @users ||= user_scope
    if params[:ids]
      ids = params[:ids].split(",").map{|x| x.to_i}
      @users = @users.where(id: ids)
    end
    @users = @users.paginate(page: params[:page], per_page: params[:per_page])
  end

  def build_user
    @user ||= user_scope.build
    @user.attributes = user_params
  end
    
  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:displayName, :gplus_url, :image_url, :about_me, :gender, :gplus_id) : {}
  end

  def user_scope
    User.all
  end

  def user
    @user
  end

  def users
    @users
  end
end
