module Rules
  module BaseRules

    def error_message
      self.errors.full_messages.first
    end

    def t_error(field, type = :invalid, options = {})
      self.errors.generate_message(field, type, options)
    end

    def error_strange_situation
      I18n.translate(:strange_situation, :scope => [:activerecord, :errors])
    end

    def rule_translate(key, options = {})
      I18n.translate(key, options.merge(:scope => [:activerecord, :errors, :models, self.class.name.underscore]))
    end

  end
end