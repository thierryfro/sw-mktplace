class ProductPhoto < ApplicationRecord
    belongs_to :product, optional: true

    validates :url, :name, :size, presence: true
end
