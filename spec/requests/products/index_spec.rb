require 'rails_helper'

describe 'index' do
    let!(:product1) { Product.create(title: 'Creatine', price: 1500) }
    let!(:product2) { Product.create(title: 'BCAA', price: 2000) }

    it 'returns a list of products' do
      # Send a GET request to the index action
      get '/products'
      
     # response should have HTTP Status 200 OK
      expect(response.status).to eq(200)

      # Parse the response body as JSON
      json_response = JSON.parse(response.body)

      # Expect the response to contain two products
      expect(json_response.length).to eq(2)

      # Verify that each product in the response has the expected attributes
      expect(json_response.first['title']).to eq('Creatine')
      expect(json_response.first['price']).to eq(1500)
      expect(json_response.second['title']).to eq('BCAA')
      expect(json_response.second['price']).to eq(2000)
    end
end