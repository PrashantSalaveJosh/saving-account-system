class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: %i[show update destroy]
  before_action :set_role_id, only: [:create]

  def index
    @user = User.where(role_id: Role.find_by(key:'customer'))
    render json: @user,
           status: :ok,
           except: %i[created_at updated_at jti ]
  end

  def show 
    if @user
      render json: @user,
             status: :ok,
             except: %i[created_at updated_at jti ]
    else
      render json: { message: I18n.t('user.show.failure'),
             errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    if @user.save
      render json: { message: I18n.t('user.create.success'), data: @user},
             status: :created,
             except: %i[created_at updated_at jti ]
    else
      render json: { message: I18n.t('user.create.failure'),
             errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: { message: I18n.t('user.update.success'), data: @user},
             status: :ok,
             except: %i[created_at updated_at jti ]
    else
      render json: { message: I18n.t('user.update.failure'),
             errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @user.update(status: 'inactive')
      render json: { message: I18n.t('user.destroy.success') },
             status: :ok
    else
      render json: { message: I18n.t('user.destroy.failure'),
             errors: @user.errors.full_messages },
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

  def set_role_id
    @user = User.new(customer_user_params)
    if @user.role_id == nil
      @user.role_id = Role.find_by(key: 'customer').id
    end
    @user
  end
end
