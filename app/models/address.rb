class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :carts, dependent: :destroy

  validates :zipcode, presence: true
end
