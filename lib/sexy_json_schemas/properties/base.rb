module SexyJSONSchemas
  module Properties
    class Base
      def self.type(attr)
        define_method("type") do
          attr
        end
      end

      attr_reader :name

      def initialize(name, options = {})
        @name = name
        @options = options
      end

      def as_json
        json = {
          "type" => type
        }

        if @options[:required]
          json['required'] = true
        end

        json
      end
    end
  end
end
