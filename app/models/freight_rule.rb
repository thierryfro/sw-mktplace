class FreightRule < ApplicationRecord
  belongs_to :store
  has_one :freight_weight, dependent: :destroy
  has_many :zip_code_zones, dependent: :destroy

  accepts_nested_attributes_for :freight_weight, allow_destroy: true
  accepts_nested_attributes_for :zip_code_zones, allow_destroy: true

  validates :price, presence: true
  validates_uniqueness_of :price, scope: %i[freight_weight zip_code_zones]
end
