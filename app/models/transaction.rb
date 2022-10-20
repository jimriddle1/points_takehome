class Transaction < ApplicationRecord
  validates :payer, presence: true
  validates :points, presence: true
  validates :timestamp, presence: true

  def self.points_balance
    # binding.pry
  end

end
