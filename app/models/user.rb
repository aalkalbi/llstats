class User < ActiveRecord::Base
  #A - when we do not have a attribute in table. Then we define it in model as virtual attribute using "attr_accessor"
  attr_accessor :password
  attr_accessor :is_a_coach

  #A - it is before filter. It will execute before Save method while user creation and encrypt password for security reasons. We used Ruby's "BCrypt" library to encrypt password.
  before_save :encrypt_password
  
  #A - Checking validation of attributes while creating and updating Users.
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :is_a_coach, :first_name,:last_name,:dob

 
  #A - This method authenticate the user. User enter username and password and we authenticate it using our encryption mechanism.This method get called in "sessions_controller.rb line no. 8 as User.authenticate".
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  #A - This method we called as before_save (see above before_save :encrypt_password). It encrypt the password using ruby's library BCrypt. We do not need to understand the encryption logic running internally.
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end


