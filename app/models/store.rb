# frozen_string_literal: true

class Store < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :address, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true, reject_if: :all_blank, allow_destroy: true

  has_many :user_stores, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  has_many :offers, dependent: :destroy

  has_many :freight_rules, dependent: :destroy
  has_many :zip_code_zones, through: :freight_rules

  has_many :users, through: :user_stores
  has_many :users, through: :user_ratings

  validates :cnpj, presence: true, uniqueness: true
  validates :name, :email, :comercial_name, presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  validates_cnpj :cnpj

  def find_weight_rules(weight)
    freight_rules
      .joins(:freight_weight)
      .where(
        'freight_weights.min_weight <= ? AND freight_weights.max_weight >= ?',
        weight, weight
      )
  end

  def find_zone_rules(zip_code)
    freight_rules
      .joins(:zip_code_zones)
      .where(
        'zip_code_zones.start_zip_code <= ? AND zip_code_zones.end_zip_code >= ?',
        zip_code, zip_code
      )
  end

  def self.delivers_in(zip_code)
    Store
      .joins(:zip_code_zones)
      .where(
      'zip_code_zones.start_zip_code <= ? AND zip_code_zones.end_zip_code >= ?',
      zip_code, zip_code
    )
  end
end
