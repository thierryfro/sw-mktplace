class Product < ApplicationRecord
  include PgSearch::Model

    before_save :capitalize_weight

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

    acts_as_taggable
    acts_as_taggable_on :tags


    # get information to use on filter form
    products_ids = OfferProduct.all&.pluck(:product_id)&.uniq # takes the product identifier that contains offers
    products = Product.where(id: products_ids)&.uniq # get products

    $brands = Brand.where(id: products&.pluck(:brand_id))&.pluck(:name)&.reject(&:blank?)&.uniq
    $categories = Category.where(id: products&.pluck(:category_id))&.pluck(:name)&.reject(&:blank?)&.uniq
    $subcategories = Subcategory.where(id: products&.pluck(:subcategory_id))&.pluck(:name)&.reject(&:blank?)&.uniq
    $weight = products&.pluck(:weight)&.reject(&:blank?)&.uniq


    def capitalize_weight
      self.weight = self.weight&.capitalize
    end
end
