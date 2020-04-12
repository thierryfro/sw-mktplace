class FreightZone < ApplicationRecord
  belongs_to :store

  has_one :freight_rule, dependent: :destroy

  validates :zone, presence: true

end
