class Chart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :freight_rule, optional: true
  has_many :chart_offers
end
