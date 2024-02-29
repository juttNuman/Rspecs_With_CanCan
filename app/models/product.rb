class Product < ApplicationRecord
  validates :title, presence: true, allow_blank: false
  validates :price, presence: true, allow_blank: false
end
