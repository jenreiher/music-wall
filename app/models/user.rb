class User < ActiveRecord::Base

  attr_accessor :password_confirmation

  has_many :tracks

  validates :username, uniqueness: { case_sensitive: false, message: "this username already exists" }
  validates :email, confirmation: { message: "does not match" }
  validates :email_confirmation, presence: true
  validates :password, confirmation: { message: "does not match" }
  validates :password_confirmation, presence: true

end