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

     response_body = JSON.parse(response.body, symbolize_names: true)
     attributes = response_body[:data][:attributes]

     expect(attributes[:payer]).to eq("DANNON")
     expect(attributes[:points]).to eq(1000)
     expect(attributes[:timestamp]).to eq("2020-11-02T14:00:00Z")

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

  it 'gives me the current balance' do
    transaction_params_1 = {
      payer: 'DANNON',
      points: 1000,
      timestamp: "2020-11-02T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_1 }, as: :json
    transaction_params_2 = {
      payer: 'UNILEVER',
      points: 200,
      timestamp: "2020-10-31T11:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_2 }, as: :json
    transaction_params_3 = {
      payer: 'DANNON',
      points: -200,
      timestamp: "2020-10-31T15:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_3 }, as: :json
    transaction_params_4 = {
      payer: 'MILLER COORS',
      points: 10000,
      timestamp: "2020-11-01T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_4 }, as: :json
    transaction_params_5 = {
      payer: 'DANNON',
      points: 300,
      timestamp: "2020-10-31T10:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_5 }, as: :json


     get '/api/v1/transactions/'
     expect(response).to be_successful
     response_body = JSON.parse(response.body, symbolize_names: true)

     expect(response_body[:data][:DANNON]).to eq(1100)
     expect(response_body[:data][:UNILEVER]).to eq(200)
     expect(response_body[:data][:"MILLER COORS"]).to eq(10000)
  end

  it 'spends points given an amount to spend, updates point balance' do
    transaction_params_1 = {
      payer: 'DANNON',
      points: 1000,
      timestamp: "2020-11-02T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_1 }, as: :json
    transaction_params_2 = {
      payer: 'UNILEVER',
      points: 200,
      timestamp: "2020-10-31T11:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_2 }, as: :json
    transaction_params_3 = {
      payer: 'DANNON',
      points: -200,
      timestamp: "2020-10-31T15:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_3 }, as: :json
    transaction_params_4 = {
      payer: 'MILLER COORS',
      points: 10000,
      timestamp: "2020-11-01T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_4 }, as: :json
    transaction_params_5 = {
      payer: 'DANNON',
      points: 300,
      timestamp: "2020-10-31T10:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_5 }, as: :json

     spend_point_params = {"points": 5000}

     patch '/api/v1/transactions/spend', params: { spend_point: spend_point_params }, as: :json

     expect(response).to be_successful
     response_body = JSON.parse(response.body, symbolize_names: true)

     data_array = response_body[:data]

     expect(data_array).to be_an(Array)

     expect(data_array[0][:payer]).to eq("MILLER COORS")
     expect(data_array[1][:payer]).to eq("UNILEVER")
     expect(data_array[2][:payer]).to eq("DANNON")

     expect(data_array[0][:points]).to eq(-4700)
     expect(data_array[1][:points]).to eq(-200)
     expect(data_array[2][:points]).to eq(-100)

     get '/api/v1/transactions/'
     expect(response).to be_successful
     response_body = JSON.parse(response.body, symbolize_names: true)

     expect(response_body[:data][:DANNON]).to eq(1000)
     expect(response_body[:data][:UNILEVER]).to eq(0)
     expect(response_body[:data][:"MILLER COORS"]).to eq(5300)


  end

  it 'throws an error if there are not enough points to spend' do
    transaction_params_1 = {
      payer: 'DANNON',
      points: 1000,
      timestamp: "2020-11-02T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_1 }, as: :json
    transaction_params_2 = {
      payer: 'UNILEVER',
      points: 200,
      timestamp: "2020-10-31T11:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_2 }, as: :json
    transaction_params_3 = {
      payer: 'DANNON',
      points: -200,
      timestamp: "2020-10-31T15:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_3 }, as: :json
    transaction_params_4 = {
      payer: 'MILLER COORS',
      points: 10000,
      timestamp: "2020-11-01T14:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_4 }, as: :json
    transaction_params_5 = {
      payer: 'DANNON',
      points: 300,
      timestamp: "2020-10-31T10:00:00Z"
      }
    post '/api/v1/transactions', params: { transaction: transaction_params_5 }, as: :json

     spend_point_params = {"points": 50000}

     patch '/api/v1/transactions/spend', params: { spend_point: spend_point_params }, as: :json

     expect(response).to_not be_successful
     response_body = JSON.parse(response.body, symbolize_names: true)

     expect(response_body[:data][:errors]).to eq("Not enough points available")


  end

end
