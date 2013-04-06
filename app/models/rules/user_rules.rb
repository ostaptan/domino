module Rules
  module UserRules

    include Rules::BaseRules

    def can_register_user?(attr)
      return false unless valid_email?(attr[:email])
      return false unless valid_password?(attr[:password_digest])
      false unless valid_names?(attr[:name], attr[:surname])
    end

    def valid_email?(email)

      if email.blank? || !(email =~ /^([0-9]{8,14})+$/)
        return false
      end

      if User.exists_mail?(email)
        return false
      end

      true
    end

    def valid_names?(name, surname)
      if name.blank? || surname.blank?
        return false
      end

      true
    end

    def valid_password?(password)

      if password.blank? || password.size < 4
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