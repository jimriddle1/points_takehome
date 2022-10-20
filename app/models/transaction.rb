class Transaction < ApplicationRecord
  validates :payer, presence: true
  validates :points, presence: true
  validates :timestamp, presence: true

  def self.points_balance
    Transaction.group(:payer).sum(:points)
  end

  def self.spend_points(amount)
    output_array = []
    original_balance = points_balance
    transactions_in_order = Transaction.order(:timestamp)

    transactions_in_order.each do |transaction|
      if transaction.points < amount
        amount -= transaction.points
        transaction.update(points: 0)
      else
        balance = transaction.points - amount
        transaction.update(points: balance)
        amount = 0
        break
      end
    end

    points_balance.each do |transaction|
      amount = transaction[1] - original_balance[transaction[0]]
      output_array << {"payer": transaction[0], "points": amount}
    end

    return output_array

  end

  def self.total_points_available
     Transaction.sum(:points)
  end

end
