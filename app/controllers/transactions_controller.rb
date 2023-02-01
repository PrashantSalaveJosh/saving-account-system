class TransactionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_transaction, only: %i[show]

  def index
    render json: Transaction.where(account_id: current_user.account), status: :ok
  end

  def show 
    if @transaction
      render json: @transaction, status: :ok
    else
      render json: { errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.transaction_type.eql?("credit")
      @transaction.balance = current_user.account.total_balance + @transaction.amount
    else
      @transaction.balance = current_user.account.total_balance - @transaction.amount
    end

    begin
      @transaction.save
    rescue
      render json: { errors: @transaction.errors.full_messages },
      status: :unprocessable_entity
    else
      current_user.account.total_balance = @transaction.balance
      render json: "transaction successfull", status: :created
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :details, :amount, :account_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
end
