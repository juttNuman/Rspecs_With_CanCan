require 'rails_helper'

describe 'index' do
  let!(:product1) { Product.create(title: 'Creatine', price: 1500) }
  let!(:product2) { Product.create(title: 'BCAA', price: 2000) }
  let(:user) { User.create(email: 'numan@gmail.com', password: '123456') }
  context 'when user is logged in' do
    before do
      sign_in user
    end
    it 'returns a list of products' do
      get '/products'
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response.first['title']).to eq('Creatine')
      expect(json_response.first['price']).to eq(1500)
      expect(json_response.second['title']).to eq('BCAA')
      expect(json_response.second['price']).to eq(2000)
    end
  end
  

end