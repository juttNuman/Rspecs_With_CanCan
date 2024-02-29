require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = Product.new(title: 'Whey Protein', price: 2000)
    expect(product).to be_valid
  end

  it "is not valid without a title" do
    product = Product.new(price: 2500)
    expect(product).not_to be_valid
    expect(product.errors[:title]).to include("can't be blank")
  end

  it "is not valid without a price" do
    product = Product.new(title: 'Oatmeal')
    expect(product).not_to be_valid
    expect(product.errors[:price]).to include("can't be blank")
  end
end
