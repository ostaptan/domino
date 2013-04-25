module UserExt::Settings

  PATTERN = "[\\w\\;\\.]"

  def get_locale
    self.settings[:locale] || I18n.default_locale
  end

  def set_locale(locale)
    unless locale.blank?
      self.settings.merge!({locale: locale})
      self.save!
    end
  end

  def setting_get(key)
    return unless self.settings
    m = self.settings.match(/\|#{key}=(#{PATTERN}*)\|/)
    m.nil? ? nil : m[1]
  end

  def is_user_setting?(key)
    unless self.settings.blank?
      m = self.settings.match(/\|#{key}\||\|#{key}=(#{PATTERN}*)\|/)
      return true if (m && m[1].nil?) || (m && m[1] == "true")
    end
    false
  end

  def setting_set_permission(permission, value)
    set_user_setting "p_#{permission.to_s}", value.to_s
  end

  private

  def set_user_setting(key, value)

    reg = /\|#{key}\||\|#{key}=(#{PATTERN}*)\|/
    key_value = "|#{key}=#{value}|"

    if value.nil?
      if self.settings.match reg
        self.settings = self.settings.gsub(reg, '')
      end
    else
      return if "#{value}" == setting_get(key)

      self.settings ||= ""
      if self.settings.match reg
        self.settings = self.settings.gsub(reg, key_value)
      else
        self.settings += key_value
      end
    end
  end

end