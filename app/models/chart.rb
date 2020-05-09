class Chart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :chart_offers, dependent: :destroy
  has_many :offers, through: :chart_offers
end
