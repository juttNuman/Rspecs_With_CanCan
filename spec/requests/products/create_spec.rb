require 'rails_helper'

describe 'POST /products' do
  # 'scenario' is similar to 'it', use which you see fit
  
  scenario 'valid product attributes' do
    # send a POST request to /bookmarks, with these parameters
    # The controller will treat them as JSON 
    post '/products', params: {
      product: {
        
        title: 'Oatmeal' ,
        price: "20"
      }
    }

    # response should have HTTP Status 201 Created
    expect(response.status).to eq(201)

    json = JSON.parse(response.body).deep_symbolize_keys
    
    # check the value of the returned response hash
    expect(json[:title]).to eq('Oatmeal')
    expect(json[:price]).to eq(20)

    # 1 new bookmark record is created
    expect(Product.count).to eq(1)

    # Optionally, you can check the latest record data
    expect(Product.last.title).to eq('Oatmeal')
  end

  scenario 'invalid product attributes' do
    post '/products', params: {
      product: {
        title: 'Oatmeal',
        price: ''
      }
    }

    # response should have HTTP Status 201 Created
    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:price]).to eq(["can't be blank"])

    # no new bookmark record is created
    expect(Product.count).to eq(0)
  end
end