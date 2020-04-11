class Offer < ApplicationRecord
  belongs_to :store

  has_many :offer_products, dependent: :destroy
  has_many :products, through: :offer_products

  validates :stock, :price, :active, presence: true

  accepts_nested_attributes_for :offer_products

end
