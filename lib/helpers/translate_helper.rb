require 'i18n/exceptions'

module Helpers
  module TranslateHelper

    module Base

      def tm(value)
        ga(:money, value)
      end

      def tp(value)
        ga(:paid, value)
      end

      def tf(model, field, default = nil, options = {})
        clazz = model.is_a?(Class) ? model : model.class
        key = "#{clazz.name.underscore}.#{field}"
        I18n.t(key, options.merge({ :scope => [:activerecord, :attributes], :default => default }))
      end

      def tg(key, options = { })
        I18n.translate(key, options)
      end

      def ga(key, value)
        I18n.t(key, { :scope => [:game_attributes], :count => value})
      end

      def d(date, format = :short)
        return nil if date.nil?

        case date
          when String
            date = Time.zone.parse(date)
          when Time, DateTime
            date = date.in_time_zone
          when Date
            date = date.to_time.in_time_zone
        end

        if format == :ago
          ago = Time.current - date
          if (ago / 1.day).to_i > 0
            r = I18n.t(:date_ago_days, :count => (ago / 1.day).to_i)
          elsif (ago / 1.hour).to_i > 0
            r = I18n.t(:date_ago_hours, :count => (ago / 1.hour).to_i)
          elsif (ago / 1.minute).to_i > 0
            r = I18n.t(:date_ago_minutes, :count => (ago / 1.minute).to_i)
          else
            r = I18n.t(:date_ago_seconds, :count => (ago / 1.second).to_i)
          end
          content_tag(:span, r, :class => "date_ago")
        else
          I18n.l date, :format => format
        end
      end

      def t_navigation(url_options, default = nil)
        url_options = url_options.dup
        url_options.delete(:id) if url_options.is_a?(Hash) && (url_options[:id].is_a?(Fixnum) || url_options[:id].is_a?(ActiveRecord::Base))

        url = url_for(url_options)
        url.gsub! /\?(.)*/, ''
        url.gsub! /(\/\d+)$/, ''
        url.gsub! /\//, '.'
        url = ".root" if url == "."
        key = "views.navigation#{url}"

        begin
          r = tg(key, :throw => true)
        rescue ArgumentError => e
          return default || "translation missing: #{key}"
        end

        r.is_a?(Hash) ? r[:index] : r
      end

    end

    module View

      include Helpers::TranslateHelper::Base

      def t(key, options ={ })
        translate("#{key}", options.merge!(:rescue_format => :text)).html_safe
      end

      # translation for views, will not use template name, just controller
      # can be used for global per controller messages
      def tv(local_key, options = { })
        key = @virtual_path.gsub(%r{/_?}, ".")
        key = key.split(".").select { |k| key.split('.').last != k }.join('.')
        key = "views.#{key}.globals.#{local_key}"
        I18n.translate(key, options.merge!(:rescue_format => :text)).html_safe
      end

      private

      # Override
      # add virtual_path by default for views
      def scope_key_by_partial(key)
        if @virtual_path
          "views.#{@virtual_path.gsub(%r{/_?}, ".")}.#{key}"
        else
          raise "Cannot use t(#{key.inspect}) shortcut because path is not available"
        end
      end

    end

    module Controller

      include Helpers::TranslateHelper::Base

      def t(local_key, options = { })
        key = self.class.to_s.downcase.gsub(/::/, '.').gsub(/controller$/, '')
        key = "controllers.#{key}.#{local_key}"
        translate key, options.merge!(:rescue_format => :text)
      end
    end

    module Model
      include Helpers::TranslateHelper::Base

      def self.included(klass)
        klass.extend Helpers::TranslateHelper::Base
      end

    end

  end
end