class Transaction < ApplicationRecord
  validates :payer, presence: true
  validates :points, presence: true
  validates :timestamp, presence: true

  def self.points_balance
    output_hash = {}
    Transaction.all.each do |transaction|
      if output_hash.keys.include?(transaction[:payer])
        output_hash[transaction[:payer]] += transaction[:points]
      else
        output_hash[transaction[:payer]] = transaction[:points]
      end
    end
    return output_hash
  end

end
