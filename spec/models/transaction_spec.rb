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

    it 'should spend points given an amount in order by transaction timestamp, updates point balance' do
      transaction_1 = Transaction.create(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
      transaction_2 = Transaction.create(payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z")
      transaction_3 = Transaction.create(payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z")
      transaction_4 = Transaction.create(payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z")
      transaction_5 = Transaction.create(payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z")

      output_array = Transaction.spend_points(5000)

      expect(output_array).to be_an(Array)
      expect(output_array[0][:payer]).to eq("MILLER COORS")
      expect(output_array[1][:payer]).to eq("UNILEVER")
      expect(output_array[2][:payer]).to eq("DANNON")

      expect(output_array[0][:points]).to eq(-4700)
      expect(output_array[1][:points]).to eq(-200)
      expect(output_array[2][:points]).to eq(-100)

      points_balance = Transaction.points_balance

      expect(points_balance).to eq ({"DANNON"=>1000, "UNILEVER"=>0, "MILLER COORS"=>5300})

    end

    it 'gives me the total points available, updates as you spend points' do
      transaction_1 = Transaction.create(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
      transaction_2 = Transaction.create(payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z")
      transaction_3 = Transaction.create(payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z")
      transaction_4 = Transaction.create(payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z")
      transaction_5 = Transaction.create(payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z")

      expect(Transaction.total_points_available).to eq(11300)

      Transaction.spend_points(5000)

      expect(Transaction.total_points_available).to eq(6300)


    end
  end
end
