class Category < ApplicationRecord
    has_many :subcategories, dependent: :destroy
    has_many :products, dependent: :destroy
    accepts_nested_attributes_for :subcategories

    validates :name, presence: true
end
