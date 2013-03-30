class User < ActiveRecord::Base
  # attr_accessible :title, :body

  # md5 is needed for pasword generation
  require 'digest/md5'

  include Rules::UserRules

  GENDER_MALE = "m"
  GENDER_FEMALE = "f"
  GENDERS = [GENDER_MALE, GENDER_FEMALE]

  validates_presence_of :name, :email, :password

  has_one :history
  has_many :messages
  has_and_belongs_to_many :games

  def welcome_phrase
    "Welcome #{self.name}!"
  end

  def active?
    self.active
  end

  def male?
    self.gender == GENDER_MALE
  end

  def female?
    self.gender == GENDER_FEMALE
  end

  def is_me?
    self.id.present? && controller.try(:controller).try(:current_user).try(:id) == self.id
  end

  def is_admin?
    return true if self.is_admin
    false
  end

  def register(attr)
    self.active = true
    self.name = attr[:name]
    self.surname = attr[:surname]
    self.email = attr[:email]
    self.gender = attr[:gender]
    self.password = User.encrypt_a_password(attr[:password_digest]) if attr[:password_digest]
    self.save!
  end

  def authenticate(user_mail, user_password)
    encrypted_password = User.encrypt_a_password(user_password)
    r = User.all :conditions => ["email = ? and password = ?", user_mail, encrypted_password ]

    unless r
      encrypted_password = User.encrypt_a_password(user_password, true)
      r = User.all :conditions => ["email = ? and password = ?", user_mail, encrypted_password ]
    end

    r
  end

  private

  # private class methods
  def self.encrypt_a_password(password, case_sensitive = false)
    password = password.mb_chars.downcase unless case_sensitive
    Digest::MD5.hexdigest(password)
  end
end
