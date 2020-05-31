class CartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :cart, optional: true

  validates :quantity, presence: true
end
