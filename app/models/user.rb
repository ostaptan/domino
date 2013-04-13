# md5 is needed for pasword generation
require 'digest/md5'
require 'redis_support'
require 'fileutils'

class User < ActiveRecord::Base
  # attr_accessible :title, :body

  include FileUtils
  include RedisSupport
  include Rules::UserRules

  GENDER_MALE = "m"
  GENDER_FEMALE = "f"
  GENDERS = [GENDER_MALE, GENDER_FEMALE]

  attr_accessible :avatar
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_one :history
  has_many :messages
  has_and_belongs_to_many :games

  def welcome_phrase
    "Welcome #{self.name}!"
  end

  def nick_name
    self.email.split('@').first
  end

  def full_name
    self.name + ' ' + self.surname + ' (' + nick_name + ')'
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

  def my_message?(m_id)
    self.id == m_id
  end

  def update_online!
    self.last_seen_at = Time.now
    self.save!
  end

  def update_edited(attr)
    self.name = attr[:name]
    self.email = attr[:email]
    update_avatar!(attr[:avatar])
    self.save!
  end

  def update_avatar!(avat)
    name = avat.original_filename
    File.open(Rails.root.join('public', 'tmp_avatars', name), 'wb') do |file|
      file.write(avat.read)
    end

    FileUtils.cp "public/tmp_avatars/#{name}", "#{Rails.root}/app/assets/images/avatars/#{name}"

    self.avatar = name
  end

  def max_rating(type)
    case type.to_sym
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

  def finished_games(page)
    Game.where("finished_at is not ?", nil)
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

  def recommended_max_rating
    1300
  end

  def recommended_min_rating
    1200
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
      self.save!
    else
      return :attributes_incorrect
    end
    create_history!(self.id)
    nil
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

  def create_history!(id)
    @history = History.new
    @history.create_for_user!(id)
  end

  def online?
    self.last_seen_at < 15.minutes.ago
  end

  def self.exists_email?(email)
    User.find_by_email(email)
  end

  def self.logged_in_count
    online = RedisSupport.cache_get('users_online')
    if online
      return online
    else
      value = User.where("last_seen_at < ?", 60.seconds.ago).count
      RedisSupport.cache_put('users_online', value, expire = 10.minutes)
      return value
    end
  end


  private

  # private class methods
  def self.encrypt_a_password(password, case_sensitive = false)
    password = password.mb_chars.downcase unless case_sensitive
    Digest::MD5.hexdigest(password)
  end
end
