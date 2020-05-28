# frozen_string_literal: true

class ChartOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :chart, optional: true

  validates :quantity, presence: true

  after_save do
    chart.update_freight
  end

  def products
    offer.products
  end

  def store
    offer.store
  end
end
