module UserExt
  module Registration

    def send_account_activation
      RegistrationMailer.account_activation(self).deliver
    end

    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      UserMailer.password_reset(self).deliver
    end

    def activate_account!
      self.active = true
      self.save!
    end

    def register(attr)
      #TODO remove on production
      self.active = true
      if can_register_user?(attr)
        self.ip_address = attr[:ip]
        self.last_ip = attr[:ip]
        self.name = attr[:name]
        self.surname = attr[:surname]
        self.email = attr[:email]
        self.gender = attr[:gender]
        self.avatar = 'no_avatar.jpg'
        self.password = User.encrypt_a_password(attr[:password]) if attr[:password]
        self.save!
      else
        return :attributes_incorrect
      end
      @history = History.new.create_for_user!(self.id)
      send_account_activation
      #create_history!(self.id)
      nil
    end

    def new_guest
      self.guest = true
      self.active = true
      self.email = "guest_email_#{rand 100000}"
      self.name = "Guest"
      self.password = "Guest_pass_#{rand 100000000}"
      self.active = true
      self.generate_token(:remember_me_token)
      self.save!
      @history = History.new.create_for_user!(self.id)
      true
    end

  end
end