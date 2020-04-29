class ChartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :chart, optional: true

  validates :quantity, presence: true
end
