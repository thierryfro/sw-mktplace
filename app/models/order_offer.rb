class OrderOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :order
end
