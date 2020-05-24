
class ZipCodeZone < ApplicationRecord
  belongs_to :freight_rule, optional: true

  validates :start_zip_code, :end_zip_code, presence: true
  
end
