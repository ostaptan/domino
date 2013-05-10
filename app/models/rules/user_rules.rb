module Rules
  module UserRules

    include Rules::BaseRules

    def can_follow?(user)
      return false if user == self
      return false if self.friendships.find_by_friend_id(user.id)

      true
    end

    def can_register_user?(attr)
      return false unless valid_email?(attr[:email])
      return false unless valid_password?(attr[:password_digest])
      return false unless valid_names?(attr[:name], attr[:surname])
      true
    end

    def valid_email?(email)

      if email.blank? || !(email.include?('@')) || !(email.include?('.'))
        return false
      end

      if User.exists_email?(email)
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

    def can_join_clan?(clan)
      true
    end

    def can_create_post?
      true
    end

    def has_to_move_in_game?
      true
    end

    def can_change_mood?(post)
      return false if post.likers.include?(self.id) || post.dislikers.include?(self.id)
      true
    end

    def can_delete_post?(post)
      #TODO
      true
    end

  end

end