module SexyJSONSchemas
  module Properties
    class String
      attr_reader :name

      def initialize(name, options = {})
        @name = name
        @options = options
      end

      def as_json
        json = {
          "type" => "string"
        }

        if @options[:enum]
          json['enum'] = @options[:enum]
        end

        if @options[:required]
          json['required'] = true
        end

        json
      end
    end
  end
end
