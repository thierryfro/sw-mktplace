class Chart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :chart_offers
end
