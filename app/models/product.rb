class Product < ApplicationRecord
    belongs_to :brand, optional: true
    has_many :product_photos, dependent: :destroy 
    accepts_nested_attributes_for :product_photos
end
