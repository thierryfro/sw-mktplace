class Subcategory < ApplicationRecord
    belongs_to :category, optional: true
end

