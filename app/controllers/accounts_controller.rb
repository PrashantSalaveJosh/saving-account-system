class AccountsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_account, only: %i[show destroy update]

  def index
    render json: Account.all, status: :ok
  end

  def show 
    if @account
      render json: @account, status: :ok
    else
      render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      render json: "account created", status: :created
    else
      render json: { errors: @account.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      render json: "account updated", status: :ok
    else
      render json: { errors: @account.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:account_type, :total_balance, :user_id, :branch_id)
  end

  def set_account
    @account = Account.find(params[:id])
  end
end
