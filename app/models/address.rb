class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :carts, dependent: :destroy

  validates :street, :neighborhood, :city, :state, :zipcode, presence: true
end
