module UserExt
  module FacebookIntegration

    def registered_with_facebook?(auth)
      self.find_by_email(auth.info.email)
    end

    def from_omniauth(auth)
      if self.registered_with_facebook?(auth)
        user = find_by_email(auth.info.email)
        user.uid = auth.uid
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      else
        where(auth.slice(:provider, :uid, :email)).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name = auth.info.first_name
          user.surname = auth.info.last_name
          user.oauth_token = auth.credentials.token
          user.avatar = auth.info.image
          user.password = "facebook_pass#{rand(1000000)}_#{rand(1000000)}"
          user.email = auth.info.email
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!
          self.create_history!(user.id)
        end
      end
      user
    end

  end
end