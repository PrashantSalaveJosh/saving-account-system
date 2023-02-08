class AccountsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_account, only: %i[show update]

  def index
    render json: Account.all,
           status: :ok,
           except: %i[created_at updated_at ]
  end

  def show 
    if @account
      render json: @account,
             status: :ok,
             except: %i[created_at updated_at ]
    else
      render json: { message: I18n.t('account.show.failure'),
             errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      render json: { message: I18n.t('account.create.success') },
             status: :created
    else
      render json: { message: I18n.t('account.create.failure'),
             errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      render json: { message: I18n.t('account.update.success') }, 
             status: :ok
    else
      render json: { message: I18n.t('account.update.failure'),
             errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:account_type, :total_balance, :user_id, :branch_id)
  end

  def set_account
    @account = Account.find(params[:id])
    # @account = User.find(params[:id]).account
  end
end
