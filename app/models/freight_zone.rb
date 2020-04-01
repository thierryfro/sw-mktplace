class FreightZone < ApplicationRecord
  belongs_to :store

  validates :zone, presence: true

end
