# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, :last_name, :birthdate, presence: true
  validates :email, presence: true, 'valid_email_2/email': true

  has_many :user_stores, dependent: :destroy
  has_many :user_ratings, dependent: :destroy

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  has_one :store, :class_name => "Store", :foreign_key => 'owner_id'

  belongs_to :cart, optional: true

  has_one_attached :photo
  # has_many :stores, as: :owner, dependent: :destroy

  def payment_info
    {
      "first_name": name,
      "last_name": last_name,
      "registration_date": created_at,
    }
  end

end
