module RedisSupport

  PROJECT_KEY = "#domino#"

#  class RedisLogger < Logger
#    def initialize
#      logfile = File.open(RAILS_ROOT + '/log/redis.log', 'a')   # create log file
#      logfile.sync = true                                               # automatically flushes data to file
#      super logfile
#      self.level = Logger::DEBUG
#    end
#
#    @@logger = nil
#
#    def self.logger
#      @@logger ||= RedisLogger.new
#      @@logger
#    end
#  end

  def redis
    Thread.current[:redis_zona] ||= Redis.new :host => GameProperties::REDIS_HOST,
                                              :port => GameProperties::REDIS_PORT
#      :logger => RedisLogger.logger
  end

  def validate_redis_cache_key(key)
    raise "Incorrect KEY #{key}" unless key.gsub(/[a-zA-Z0-9 _\"\#\-\+\$\|\[\]]+/, "").blank?
    true
  end

  def cache_put(key, value, expire = nil)
    validate_redis_cache_key(key)

    if value
      value = Marshal.dump value
      redis.set(compose_redis_key(key), value, expire)
    else
      cache_del key
    end
  end

  def cache_get(key, default = nil)
    key = compose_redis_key key
    value = redis.get key
    value = Marshal.load value if value
    value || default
  end

  def cache_del(key)
    validate_redis_cache_key(key)
    key = compose_redis_key key
    redis.del key
  end

  def cache_keys(key_pattern="*")
    key = compose_redis_key key_pattern
    keys = redis.keys key
    keys.collect{|key| key.split(PROJECT_KEY)[1] }
  end

  def cache_del_keys(keys = [])
    return false if keys.empty? || !keys.is_a?(Array)

    k = keys.collect{|key| compose_redis_key(key)}
    redis.del "#{k.join(',')}"
  end

  # returns value from cache by key
  # if block will be passed, it will be evaluated and stored for missing cache value
  def cache_fetch(key, expire = nil)
    if block_given?
      result = cache_get(key)

      unless result
        result = yield
        cache_put(key, result, expire)
      end

      result
    else
      cache_get(key)
    end
  end

  def locked?(name)
    name = name + '_lock' if !name.end_with?('_lock')

    key = compose_redis_key name
    r = redis
    value = r.get key
    value && value.to_i > Time.now.to_i
  end

  def set_lock(name, time = 3.minutes)
    name = name + '_lock' if !name.end_with?('_lock')
    validate_redis_cache_key(name)

    key = compose_redis_key name
    r = redis
    if r.setnx key, (Time.now + time).to_i
      begin
        yield
      ensure
        r.del key
      end
      return true
    else
      value = r.get key
      if value.to_i < Time.now.to_i
        new_value = r.getset key, (Time.now + time).to_i
        if new_value == value
          begin
            yield
          ensure
            r.del key
          end
          return true
        end
      end
    end

    false
  end

  def compose_redis_key(key)
    "#{PROJECT_KEY}#{key}"
  end

  def merged_options(call_options)
    if call_options
      options.merge(call_options)
    else
      options.dup
    end
  end
end
