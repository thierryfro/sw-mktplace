class OfferProduct < ApplicationRecord
  belongs_to :offer
  belongs_to :product
end
