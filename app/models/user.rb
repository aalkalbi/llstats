class User < ActiveRecord::Base
  #A - when we do not have a attribute in table. Then we define it in model as virtual attribute using "attr_accessor"
  attr_accessor :password,:is_a_coach,:is_pass_reset

  #A - it is before filter. It will execute before Save method while user creation and encrypt password for security reasons. We used Ruby's "BCrypt" library to encrypt password.
  before_save :encrypt_password
  
  #A - Checking validation of attributes while creating and updating Users.
  validates_confirmation_of :password, :unless => :is_pass_reset?
  validates :password, :length =>{
    :minimum => 8,
    :too_short => "is too short, must be at least %{count} characters"
  }, :on => :create, :unless => :is_pass_reset?
  validates_presence_of :password, :on => :create, :unless => :is_pass_reset?
  validates_presence_of :email, :unless => :is_pass_reset?
  validates_uniqueness_of :email, :unless => :is_pass_reset?
  validates_presence_of :is_a_coach, :first_name,:last_name,:dob, :unless => :is_pass_reset?

  #add extra validations while password reset.
  validates_presence_of :password, :if => :is_pass_reset?
  validates :password, :length =>{
    :minimum => 8,
    :too_short => "is too short, must be at least %{count} characters"
  }, :if => :is_pass_reset?
  validates_confirmation_of :password, :if => :is_pass_reset?

 def is_pass_reset?
   reset = false
   if is_pass_reset.to_s == "true"
    reset = true
   end
 end

 
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

  #Forgotten password and reset password.
  before_create { generate_token(:auth_token) }

def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!(validate: false)
  UserMailer.password_reset(self).deliver
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end
end


