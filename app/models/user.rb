class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  #username validation
  validates :username, presence: true, length: { maximum: 50 }

  #email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  #make password secure
  include BCrypt
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :username

  #validations
  validates_presence_of :email,:message=>"Email ID Field cannot be blank", format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, :message => "Sorry this Email ID is already registered."
  validates_presence_of :username,:message=>"Username Field cannot be blank"
  validates_uniqueness_of :username, :message => "Sorry this Username is already registered."


  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
