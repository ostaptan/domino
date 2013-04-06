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
  has_one :game

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

  def max_rating(type)
    case type
      when :goat
        history.g_max_rating
      when :spider
        history.s_max_rating
      else
        #TODO make a constant
        1200
    end
  end

  def all_games_count(type)
    case type
      when :goat
        history.g_a_lost + history.g_a_won
      when :spider
        history.s_a_lost + history.s_a_won
      else
        0
    end
  end

  def won_games_count(type)
    case type
      when :goat
        history.g_a_won
      when :spider
        history.s_a_won
      else
        0
    end
  end

  def lost_games_count(type)
    case type
      when :goat
        history.g_a_lost
      when :spider
        history.s_a_lost
      else
        0
    end
  end

  def register(attr)
    #TODO set false unless user confirmed email
    self.active = true
    if can_register_user?(attr)
      self.name = attr[:name]
      self.surname = attr[:surname]
      self.email = attr[:email]
      self.gender = attr[:gender]
      self.password = User.encrypt_a_password(attr[:password_digest]) if attr[:password_digest]
      self.build_history
      self.history.save!
      self.save!
    else
      :attributes_incorrect
    end
  end

  def authenticate(user_mail, user_password)
    encrypted_password = User.encrypt_a_password(user_password)
    r = User.all :conditions => ["email = ? and password = ?", user_mail, encrypted_password]

    unless r
      encrypted_password = User.encrypt_a_password(user_password, true)
      r = User.all :conditions => ["email = ? and password = ?", user_mail, encrypted_password]
    end

    r
  end

  def exists_email?(email)
    User.find_by_email(email)
  end


  private

  # private class methods
  def self.encrypt_a_password(password, case_sensitive = false)
    password = password.mb_chars.downcase unless case_sensitive
    Digest::MD5.hexdigest(password)
  end
end
