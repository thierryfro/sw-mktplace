# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :birthdate, presence: true
  validates :email, presence: true, 'valid_email_2/email': true

  has_many :user_stores, dependent: :destroy
  has_many :user_ratings, dependent: :destroy
  belongs_to :cart, optional: true
  # has_many :stores, as: :owner, dependent: :destroy
end
