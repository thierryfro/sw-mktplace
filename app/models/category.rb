class Category < ApplicationRecord
    has_many :subcategories, dependent: :destroy 
    accepts_nested_attributes_for :subcategories
end
