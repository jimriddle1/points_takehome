require 'rails_helper'

RSpec.describe 'Transactions API' do
  it 'can create a new transaction' do

    transaction_params = {
      payer: 'DANNON',
      points: 1000,
      timestamp: "2020-11-02T14:00:00Z"

      }

     post '/api/v1/transactions', params: { transaction: transaction_params }, as: :json
     expect(response).to be_successful

     created_transaction = Transaction.last

     expect(created_transaction).to be_a(Transaction)
     expect(created_transaction.payer).to be_a(String)
     expect(created_transaction.points).to be_a(Integer)
     expect(created_transaction.timestamp).to be_a(String)
  end

  it 'can create a new transaction - sad path' do

    transaction_params = {
      payer: 'DANNON'
      }

     post '/api/v1/transactions', params: { transaction: transaction_params }, as: :json
     expect(response).to_not be_successful
     response_body = JSON.parse(response.body, symbolize_names: true)

     expect(response_body[:data][:errors][0]).to eq("Points can't be blank")
     expect(response_body[:data][:errors][1]).to eq("Timestamp can't be blank")

  end

end
