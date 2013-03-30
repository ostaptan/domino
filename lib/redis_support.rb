module RedisSupport

  def validate_redis_cache_key(key)
    raise "Incorrect KEY #{key}" unless key.gsub(/[a-zA-Z0-9 _\"\#\-\+\$\|\[\]]+/, "").blank?
    true
  end

  def cache_put(key, value, expire = 5.days)
    validate_redis_cache_key(key)

    key = compose_redis_key key
    if value
      value = Marshal.dump(value)
      Rails.cache.write key, value, :expire_in => expire
    else
      Rails.cache.delete key
    end
  end

  def cache_get(key, default = nil)
    key = compose_redis_key key
    value = Rails.cache.read key
    autoload_missing_constants do
      value = Marshal.load value if value
    end
    value || default
  end

  def cache_del(key)
    validate_redis_cache_key(key)
    key = compose_redis_key key
    Rails.cache.delete key
  end

  def locked?(name)
    name = name + '_lock' if !name.end_with?('_lock')

    key = compose_redis_key name
    value = Rails.cache.read(key)
    value && value.to_i > Time.now.to_i
  end

  def set_lock(name, time = 10.seconds)
    name = name + '_lock' if !name.end_with?('_lock')
    validate_redis_cache_key(name)

    key = compose_redis_key name
    if Rails.cache.write key, (Time.now + time).to_i, :unless_exist => true
      begin
        yield
      ensure
        Rails.cache.delete key
      end
      return true
    else
      value = Rails.cache.read key
      if value.to_i < Time.now.to_i
        new_value = redis_getset key, (Time.now + time).to_i
        if new_value == value
          begin
            yield
          ensure
            Rails.cache.delete key
          end
          return true
        end
      end
    end

    false
  end

  def redis_getset(key, v)
    r = cache_get(key)
    cache_put(key, v)
    r
  end

  def compose_redis_key(key)
    key
  end

  @@lazy_load ||= Hash.new { |hash, hash_key| hash[hash_key] = true; false }

  def autoload_missing_constants
    yield
  rescue ArgumentError => error
    if error.to_s[/undefined class|referred/] && !@@lazy_load[error.to_s.split.last.sub(/::$/, '').constantize] then
      retry
    else
      raise error
    end
  end

end
