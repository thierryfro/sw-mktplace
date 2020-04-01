class FreightRule < ApplicationRecord
  belongs_to :freight_zone
  belongs_to :store
end
