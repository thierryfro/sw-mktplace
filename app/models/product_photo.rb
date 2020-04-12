class ProductPhoto < ApplicationRecord
    belongs_to :base_suplement, optional: true

    validates :url, :name, :size, presence: true
end
