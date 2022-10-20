class Api::V1::TransactionsController < ApplicationController

  def index
    render json: { data: Transaction.points_balance }
  end

  def create
    # binding.pry
    transaction = Transaction.new(payer: transaction_params[:payer],
          points: transaction_params[:points],
          timestamp: transaction_params[:timestamp])

    if transaction.save
      render json: TransactionSerializer.new(transaction), status: :created
    else
      render json: { data: { errors: transaction.errors.full_messages} }, status: 401
    end

  end

  def update
    # binding.pry
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payer, :points, :timestamp)
  end

end
