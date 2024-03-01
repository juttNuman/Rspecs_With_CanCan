require 'rails_helper'

describe 'PUT /products' do
  let!(:product) { Product.create(title: 'Whey Protein', price: '2000') }
  context 'when user is logged in & his role is admin can update' do
    let(:user) { User.create(email: 'numan@gmail.com', password: '123456', role: 'manager') }
    before do
      sign_in user
    end
  scenario 'valid product attributes will update' do
    put "/products/#{product.id}", params: {
      product: {
        title: 'Whey Protein Isolate',
        price: "2000"
      }
    }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq('Whey Protein Isolate')
    expect(json[:price]).to eq(2000)
    expect(product.reload.title).to eq('Whey Protein Isolate')
    expect(product.reload.price).to eq(2000)
  end

  scenario 'invalid product attributes' do
    put "/products/#{product.id}", params: {
      product: {
        title: '',
        price: '2000'
      }
    }
    expect(response.status).to eq(422)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(["can't be blank"])
    expect(product.reload.title).to eq('Whey Protein')
    expect(product.reload.price).to eq(2000)
  end
end

scenario 'invalid user cannot update ' do
  put "/products/#{product.id}", params: {
    product: {
      title: 'new product',
      price: '4000'
    }
  }
    expect(product.reload.title).to eq('Whey Protein')
    expect(product.reload.price).to eq(2000)
end

context 'when customer try to update' do
  let!(:user) { User.create(email:"ali@gmail.com", password:"123456", role:"customer") }
  before do
    sign_in user
  end

  scenario 'product will not delete because customer dont have acess' do
    put "/products/#{product.id}" , params:{
      product:{
        title: "new product" , 
        price: "2600"
           }
      }
      expect(product.reload.title).to eq('Whey Protein')
      expect(product.reload.price).to eq(2000)



  end


end
 
end