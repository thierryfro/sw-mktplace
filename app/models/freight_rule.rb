class FreightRule < ApplicationRecord
  belongs_to :freight_zone, optional: true
  belongs_to :store, optional: true

  validates :limit_price, :discount, presence: true

end
