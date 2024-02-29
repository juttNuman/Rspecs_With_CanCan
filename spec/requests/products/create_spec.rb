require 'rails_helper'

  describe 'POST /products' do
    let(:user) { User.create(email: 'numan@gmail.com', password: '123456') }
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'creates a new product with valid attributes' do
        post '/products', params: {
          product: {
            title: 'Oatmeal',
            price: '20'
          }
        }

        expect(response).to have_http_status(:created)
        expect(Product.count).to eq(1)

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:title]).to eq('Oatmeal')
        expect(json[:price]).to eq(20)
      end

      it 'does not create a new product with invalid attributes' do
        post '/products', params: {
          product: {
            title: 'Oatmeal',
            price: ''
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Product.count).to eq(0)

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:price]).to eq(["can't be blank"])
      end
    end

    it 'returns unauthorized' do
      post '/products', params: {
        product: {
          title: 'Oatmeal',
          price: '20'
        }
      }
    
      expect(response).to have_http_status(302)
      expect(Product.count).to eq(0)

      end
    end
  

