module Rules
  module UserRules

    include Rules::BaseRules

    def valid_phone?

      if self.phone.blank? || !(self.phone =~ /^([0-9]{8,14})+$/)
        self.errors[:base] << t_error(:phone)
        return false
      end

      if User.exists_phone?(self.phone)
        self.errors[:base] << t_error(:phone, :unique)
        return false
      end

      true
    end

    def valid_password(password)

      if self.password.blank? || self.password != password
        self.errors[:base] << t_error(:password)
        return false
      end

      true
    end

    #TODO REMOVE
    def can_change_gender(gender)
      genders = User::GENDERS.clone

      if self.gender
        self.errors[:base] << t_error(:gender, :already_defined)
        return
      end

      unless genders.compact.include?(gender)
        self.errors[:base] << t_error(:gender)
        return
      end

      true
    end

    def valid_gender?(gender)
      genders = User::GENDERS.clone
      unless genders.compact.include?(gender)
        self.errors[:base] << t_error(:gender)
        return
      end

      true
    end

    def can_change_password?(password, new_password, confirm_password, restore_password)

      unless self.try(:authenticate, password) || restore_password
        self.errors[:base] << t_error(:password, :incorrect)
        return
      end

      if password == new_password
        self.errors[:base] << t_error(:new_password, :cant_match)
        return
      end

      if new_password != confirm_password
        self.errors[:base] << t_error(:confirm_password, :not_match)
        return
      end

      true
    end

  end

end