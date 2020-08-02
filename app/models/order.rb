class Order < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :address
  belongs_to :freight_rule  
end
