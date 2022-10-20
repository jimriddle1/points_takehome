require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'methods' do
    it 'should return a balance summary' do
      transaction_1 = Transaction.create(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
      Transaction.points_balance
    end
  end
end
