require 'rails_helper'

describe 'DELET /products' do
 
  let!(:product) { Product.create(title: 'Whey Protein', price: '2000') }

  context 'when user is logged in & his role is manager' do
   let!(:user) {User.create(email:"numan@gmail.com", password: "123456", role: "manager")}
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

  context "when customer login and try to delete" do
    let!(:user){User.create(email:"ali@gmail.com", password:"123456", role:"customer")}
    before do
      sign_in user
    end
    it 'product will not delete because customer dont have aces for this' do
      delete "/products/#{product.id}"
      expect(Product.count).to eq(1)
    end
  end
  

end
