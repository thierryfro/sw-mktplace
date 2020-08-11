class CartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :cart, optional: true

  validates :quantity, presence: true

  after_save do
    cart.update_freight
  end

  def products
    offer.products
  end

  def product
    offer.products.first
  end

  def store
    offer.store
  end

  def total_price
    offer.price * quantity
  end
end
