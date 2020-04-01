class FreightRule < ApplicationRecord
  belongs_to :freight_zone
  belongs_to :store

  validates :limit_pricce, :discount, presence: true

end
