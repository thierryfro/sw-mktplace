class UserRating < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates rating:, presence: true

end
