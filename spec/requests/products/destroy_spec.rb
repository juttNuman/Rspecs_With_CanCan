require 'rails_helper'

describe 'DELET /products' do
  let(:user) { User.create(email: 'numan@gmail.com', password: '123456') }
  let!(:product) { Product.create(title: 'Whey Protein', price: '2000') }

  context 'when user is logged in' do
    before do
      sign_in user
    end
  
    scenario 'valid product deletion' do
    delete "/products/#{product.id}"
    
    expect(Product.count).to eq(0)
    end

  end

  scenario 'invalid user cannot delete the product' do 
    delete "/products/#{product.id}"
    expect(response).to have_http_status(302)
    expect(Product.count).to eq(1)
  end
  

end
