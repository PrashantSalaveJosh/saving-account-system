class TransactionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_transaction, only: %i[show]
  before_action :set_balance, only: [:create]

  def index
    render json: Transaction.where(account_id: User.find(params[:user_id]).account),
           status: :ok,
           except: %i[ updated_at ]
  end

  def show 
    if @transaction
      render json: @transaction, 
             status: :ok,
             except: %i[ updated_at ]
    else
      render json: { message: I18n.t('transaction.show.failure'),
             errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    if @transaction.save
      Account.find(@transaction.account_id).update(total_balance: @transaction.balance)
      render json: { message: I18n.t('transaction.create.success'), data: @transaction }, 
             status: :created
    else
      render json: { message: I18n.t('transaction.create.failure'),
             errors: @transaction.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :details, :amount, :account_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_balance
    @transaction = Transaction.new(transaction_params)
    if @transaction.transaction_type.eql?("credit")
      @transaction.balance = current_user.account.total_balance + @transaction.amount
    else
      @transaction.balance = current_user.account.total_balance - @transaction.amount
    end
    return @transaction
  end

end
