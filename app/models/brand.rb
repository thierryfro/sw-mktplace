class Brand < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_name, 
  against: [:search_name],
  using: {
    tsearch: { prefix: true }
  }
end
