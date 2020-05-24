class FreightRule < ApplicationRecord
    belongs_to :freight_weight
    belongs_to :zip_code_zone
    belongs_to :store

    accepts_nested_attributes_for :zip_code_zone,
                                  :freight_weight

    validates :price, presence: true
    validates :zip_code_zone_id, uniqueness: {scope: :freight_weight_id}
end
