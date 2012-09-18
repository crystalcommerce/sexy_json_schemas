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

        if @options[:enum]
          json['enum'] = @options[:enum]
        end

        json
      end
    end
  end
end
