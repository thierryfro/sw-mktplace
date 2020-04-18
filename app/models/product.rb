class Product < ApplicationRecord
  include PgSearch::Model

    belongs_to :brand, optional: true
    belongs_to :category
    belongs_to :subcategory, optional: true

    has_many :product_photos, dependent: :destroy
    has_many :offer_products, dependent: :destroy
    has_many :offers, through: :offer_products


    accepts_nested_attributes_for :product_photos,
                                  :brand,
                                  :category,
                                  :subcategory

    validates :name, :ean, :api_code, presence: true

    pg_search_scope :search_products,
    against: [:name, :description, :flavor, :ean, :weight ],
    associated_against: {
      brand: [ :name ],
      category: [ :name ],
      subcategory: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }

end
