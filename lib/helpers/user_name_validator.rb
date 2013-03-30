#TODO
module Helpers
  class UserNameValidator

    class << self

      def valid?(text)
        return false if text.blank?

        text = text.downcase

        # user can create name with spaces
        text = text.gsub(' ', '')
        text = text.gsub('_', '')

        name_filters.each do |filter|
          return false if text.match /#{filter}/
        end

        true
      end

      private

      def name_filters
        return []
        #TODO
        return @@values if @@values

        @@values = []

        File.open(File.join(Rails.root, "lib", "yml", "name_filter.txt"), "r") do |f|
          while line = f.gets
            line.strip!
            @@values.push(line)
          end
        end

        @@values

      end
    end

    private

    @@values = nil

  end
end

