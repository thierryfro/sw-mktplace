class ProductPhoto < ApplicationRecord
    belongs_to :base_suplement, optional: true
end
