class Offer < ApplicationRecord
  belongs_to :store

  has_many :offer_products, dependent: :destroy
  has_many :products, through: :offer_products

  validates :stock, :price, presence: true

  accepts_nested_attributes_for :offer_products, reject_if: :all_blank, allow_destroy: true

end
