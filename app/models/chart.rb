class Chart < ApplicationRecord
  belongs_to :user, optional: true
end
