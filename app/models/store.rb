class Store < ApplicationRecord

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many user_stores:, user_ratings:, freight_zones:, freght_rules:, offers:
  has_many users:, through: :user_stores
  has_many users:, through: :user_ratings

  validates name:, email:, cnpj:, comercial_name:, presence: true

end
