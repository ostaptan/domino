# md5 is needed for pasword generation
require 'digest/md5'
require 'redis_support'
require 'fileutils'

class User < ActiveRecord::Base
  # attr_accessible :title, :body

  serialize :settings, Hash

  include FileUtils
  include RedisSupport
  include Rules::UserRules
  include GamesExt::GamesMethods
  include UserExt::Settings
  include UserExt::Registration
  include UserExt::Notifications
  include Tire::Model::Search
  include Tire::Model::Callbacks

  GENDER_MALE = "m"
  GENDER_FEMALE = "f"
  GENDERS = [GENDER_MALE, GENDER_FEMALE]
  ADMIN_ID = 4

  attr_accessible :avatar, :latitude, :longitude, :password_reset_sent_at, :password_reset_token, :password, :is_admin, :active, :clan_id
  validates_presence_of :name, :email, :password, unless: :guest?
  validates_confirmation_of :password, unless: :guest?
  validates_length_of :password, minimum: 4, unless: :guest?
  validates_uniqueness_of :email, unless: :guest?

  has_one :history
  has_many :messages
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_and_belongs_to_many :domino_games
  has_many :news, :class_name => DashboardNews
  has_many :comments, :class_name => DashboardComment

  belongs_to :clan

  geocoded_by :location
  after_validation :geocode

  scope :active, where(active: true)

  before_create { generate_token(:remember_me_token) }

  class << self
    include UserExt::FacebookIntegration
  end

  def welcome_phrase
    "Welcome #{self.name}!"
  end

  def guest?
    self.guest
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

  def address
    self.country + ',' + self.location
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

  alias_method  :moderator?, :is_admin?

  def super_admin?
    self.id == ADMIN_ID
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
    self.surname = attr[:surname]
    self.email = attr[:email]
    self.country = attr[:country]
    self.location = attr[:location]
    self.birth_date = attr[:birth_date]
    update_avatar!(attr[:avatar]) if attr[:avatar]
    self.save!
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  def update_avatar!(avat)
    name = "#{self.id.to_s}.jpg"
    File.open(Rails.root.join('public', 'tmp_avatars', name), 'wb') do |file|
      file.write(avat.read)
    end

    FileUtils.cp "public/tmp_avatars/#{name}", "#{Rails.root}/app/assets/images/avatars/#{name}"
    File.delete("public/tmp_avatars/#{name}") if File.exist?("public/tmp_avatars/#{name}")
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

  def recommended_max_rating
    1300
  end

  def recommended_min_rating
    1200
  end

  def reset_password!(attr)
    self.password = User.encrypt_a_password(attr[:password]) if attr[:password]
    self.save!
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

  def from_facebook?
    self.provider == 'facebook'
  end

  def self.create_history!(id)
    @history = History.new.create_for_user!(id)
  end

  def online_status
    'Online' if self.online?
  end

  def online?
    self.last_seen_at > 15.minutes.ago
  end

  def self.online
    active.select {|u| u.online?}
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
