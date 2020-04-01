class ChartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :chart

  validates quantity:, presence: true
end
