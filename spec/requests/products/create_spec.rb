require 'rails_helper'

  describe 'POST /products' do
    
    context 'when user is logged and have authorization' do
      let(:user) { User.create(email: 'numan@gmail.com', password: '123456' , role: 'manager') }
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
        expect(json[:error]).to eq("Unprocessable Entity")
        expect(json[:message]).to eq(["Price can't be blank"])
      end
      
    end

    it 'returns unauthorized' do
      post '/products', params: {
        product: {
          title: 'Oatmeal',
          price: '20'
        }
      }
      expect(response).to have_http_status(:unauthorized)
      expect(Product.count).to eq(0)
      end

      context 'when user is logged and have dont have authorization' do
        let(:user) { User.create(email: 'ali@gmail.com', password: '123456' , role: 'customer') }
        before do
          sign_in user
        end
        it 'product will not create with customer' do
          post '/products' , params:{
            product:{
              title: 'Brocoll' ,
              price: '200'
            }
          }
          expect(response).to have_http_status(302)
          expect(Product.count).to eq(0)

          puts "Response Body: #{response.body}"

          json_response = JSON.parse(response.body).deep_symbolize_keys
          expect(json_response[:errors]).to include('You are not authorized to access this page.')

        end
      end




    end
  

