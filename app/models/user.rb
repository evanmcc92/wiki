class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  include BCrypt
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :username

  validates_presence_of :email,:message=>"Email ID Field cannot be blank", format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, :message => "Sorry this Email ID is already registered."
  validates_presence_of :username,:message=>"Username Field cannot be blank"
  validates_uniqueness_of :username, :message => "Sorry this Username is already registered."
end
