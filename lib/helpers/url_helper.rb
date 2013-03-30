module Helpers
  module UrlHelper

    def self.included(c)
      if c.respond_to?(:helper_method)
        c.helper_method(:sym_params)
        c.helper_method(:set_url_param)
        #TODO MOVE HELPER
        c.helper_method :team_logo_url
      end
    end

    def sym_params(name, default = nil)
      v = params[name]
      v.blank? ? default : v.to_sym
    end

    def set_url_param(options, param, value)
      if options.class == String
        if value
          v = "#{param.to_s}=#{value.to_s}"
        else
          v = ""
        end

        if m = options.match(/#{param}=(\w*)/)
          options = options.gsub(m[0], v)
        else
          if options.include?('#')
            anchor = options[options.rindex('#'), options.length]
            options.gsub!(/#{anchor}/, '')
          end

          options += options.include?('?') ? '&' : '?'
          options += v
          options += anchor if defined?(anchor) && anchor

        end
        if options.ends_with?("?") || options.ends_with?("&")
          options = options[0..options.length - 2]
        end
        options
      else
        options.update(param => value)
      end
    end

  end

end