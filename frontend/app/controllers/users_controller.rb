class UsersController < ApplicationController
  require_permission :users, except: :count
  skip_before_action :check_auth, only: :count

  helper_method :user
  helper_method :users

  def index
    load_users
    respond_to do |format|
      format.html { render }
      format.json { render json: @users}
    end
  end

  def show
    load_user
  end

  def new
    build_user
  end

  def edit
    load_user
    build_user
  end

  def create
    build_user
    respond_to do |format|
      if user.save
        format.html { redirect_to user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: user }
      else
        format.html { render :new }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    load_user
    build_user
    respond_to do |format|
      if user.save
        format.html { redirect_to user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @ser }
      else
        format.html { render :edit }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    load_user
    user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    @users ||= user_scope.load_collection(params.permit(:page, :per_page))
  end

  def build_user
    @user ||= user_scope.new
    @user.attributes = user_params
  end
    
  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:displayName, :gplus_url, :image_url, :about_me, :gender, :gplus_id) : {}
  end

  def user_scope
    User
  end

  def user
    @user
  end

  def users
    @users
  end
end
