class SessionsController < ApplicationController
  def show
    render json: resource
  end

  def index
    render json: resources
  end

  def create
    if sess = resource_scope.create()
      render json: sess
    else
      render json: {errors: sess.errors}, status: :unprocessable_entity
    end
  end

  def update
    if resource.update_attributes(obj_data: resource_params)
      render json: resource
    else
      render json: {errors: sess.errors}, status: :unprocessable_entity
    end
  end

  def login
    account = OauthAccount.auth_account(params[:email], params[:password])
    if account && begin
                    resource.obj_data[:account_id] = account.id
                    resource.save
                  end
      render json: resource
    else
      render json: {status: :incorrect}, status: :unprocessable_entity
    end
  end

  def logout
    if resource && begin
                     resource.obj_data[:account_id] = nil
                     resource.save
                   end
      render json: resource
    else
      render json: {status: :failed}, status: 500
    end
  end
  
  protected

  def resource
    @session ||= resource_scope.find_by_key!(params[:id])
  end

  def resources
    @sessions ||= resource_scope.all
  end

  def resource_scope
    Session
  end

  def resource_params
    params[:session]
  end

  def login_params
    params.require(:email, :password)
  end
end
