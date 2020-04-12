class Brand < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_name,
  against: [:search_name],
  using: {
    tsearch: { prefix: true }
  }

  has_many :products, dependent: :destroy
  validates :name, :search_name, presence: true
end
