class Api::V1::TransactionsController < ApplicationController

  def index
    binding.pry
  end

  def create
    # binding.pry
    transaction = Transaction.create(payer: transaction_params[:payer],
          points: transaction_params[:points],
          timestamp: transaction_params[:timestamp])

    if transaction.save
      render json: TransactionSerializer.new(Transaction.create(transaction_params)), status: :created
    else
      # binding.pry
      render json: { data: { errors: transaction.errors.full_messages} }, status: 401
    end

  end

  def spend

  end

  private

  def transaction_params
    params.require(:transaction).permit(:payer, :points, :timestamp)
  end

end
