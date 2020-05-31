class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_offers, dependent: :destroy
  has_many :offers, through: :cart_offers
end
