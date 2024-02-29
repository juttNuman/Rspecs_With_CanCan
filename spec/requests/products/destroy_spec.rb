require 'rails_helper'

describe 'DELET /products' do
  # this will create a 'product' method, which return the created bookmark object, 
  # before each scenario is ran
  let!(:product) { Product.create(title: 'Whey Protein', price: '2000') }

    scenario 'valid product deletion' do
        # Send a DELETE request to the destroy action
        expect {
          delete "/products/#{product.id}"
        }.to change(Product, :count).by(-1)
  
        # Expect the response to have a status of 204 (No Content)
        expect(response.status).to eq(204)
    end





end
