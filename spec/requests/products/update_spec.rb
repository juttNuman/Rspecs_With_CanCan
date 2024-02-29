require 'rails_helper'

describe 'PUT /products' do
  # this will create a 'product' method, which return the created bookmark object, 
  # before each scenario is ran
  let!(:product) { Product.create(title: 'Whey Protein', price: '2000') }

  scenario 'valid product attributes' do
    # send put request to /products/:id
    put "/products/#{product.id}", params: {
      product: {
        title: 'Whey Protein Isolate',
        price: "2000"
      }
    }

    # response should have HTTP Status 200 OK
    expect(response.status).to eq(200)

    # response should contain JSON of the updated object
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq('Whey Protein Isolate')
    expect(json[:price]).to eq(2000)

    # The bookmark title and url should be updated
    expect(product.reload.title).to eq('Whey Protein Isolate')
    expect(product.reload.price).to eq(2000)
  end

  scenario 'invalid product attributes' do
    # send put request to /bookmarks/:id
    put "/products/#{product.id}", params: {
      product: {
        title: '',
        price: '2000'
      }
    }

    # response should have HTTP Status 422 Unprocessable entity
    expect(response.status).to eq(422)

    # response should contain error message
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(["can't be blank"])

    # The bookmark title and url remain unchanged
    expect(product.reload.title).to eq('Whey Protein')
    expect(product.reload.price).to eq(2000)
  end
end