class Product < ApplicationRecord
    belongs_to :brand, optional: true
    belongs_to :category
    belongs_to :subcategory, optional: true

    has_many :product_photos, dependent: :destroy
    has_many :offer_products, dependent: :destroy
    has_many :offers, through: :offer_products


    accepts_nested_attributes_for :product_photos

    validates :name, :ean, :api_code, presence: true
end
