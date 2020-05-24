class Store < ApplicationRecord

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :user_stores, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :freight_rules, dependent: :destroy
  has_many :users, through: :user_stores
  has_many :users, through: :user_ratings

  validates :cnpj, presence: true, uniqueness: true
  validates :name, :email, :comercial_name, presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  validates_cnpj :cnpj


end
