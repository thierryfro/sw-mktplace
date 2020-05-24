class FreightWeight < ApplicationRecord
    belongs_to :freight_rule

    validates :min_weight, :max_weight, presence: true
end
