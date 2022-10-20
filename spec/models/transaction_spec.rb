require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'methods' do
    it 'should return a balance summary' do
      transaction_1 = Transaction.create(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
      transaction_2 = Transaction.create(payer: "UNILEVER", points: 200, timestamp: "2010-11-02T14:00:00Z")
      transaction_3 = Transaction.create(payer: "DANNON", points: -200, timestamp: "2021-11-02T14:00:00Z")
      transaction_4 = Transaction.create(payer: "MILLER COORS", points: 10000, timestamp: "2022-11-02T14:00:00Z")
      transaction_5 = Transaction.create(payer: "DANNON", points: 300, timestamp: "2019-11-02T14:00:00Z")
      points_balance = Transaction.points_balance

      expect(points_balance).to eq ({"DANNON"=>1100, "UNILEVER"=>200, "MILLER COORS"=>10000})
    end
  end
end
