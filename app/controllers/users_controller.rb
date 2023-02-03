class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: %i[show update]

  def index
    render json: User.where(role_id: Role.find_by(key:'customer')), status: :ok
  end

  def show 
    if @user
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(customer_user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact_no, :address, :dob, :gender)
  end

  def customer_user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
