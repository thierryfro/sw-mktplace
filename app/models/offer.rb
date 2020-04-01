class Offer < ApplicationRecord
  belongs_to :store

  validates stock:, price:, active:, presence: true

end
