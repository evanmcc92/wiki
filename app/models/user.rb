class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :trends

  #username validation
  validates :username, presence: true, length: { maximum: 50 }

  #email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  #make password secure
  attr_accessor :password
  before_save :encrypt_password

  attr_accessible :email, :password, :password_confirmation, :username, :admin

  #validations
  validates_presence_of :email,:message=>"Email ID Field cannot be blank", format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, :message => "Sorry this Email ID is already registered."
  validates_presence_of :username,:message=>"Username Field cannot be blank"
  validates_uniqueness_of :username, :message => "Sorry this Username is already registered."


  before_create :create_remember_token

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

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
