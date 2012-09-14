module SexyJSONSchemas
  module Properties
    class String
      attr_reader :name

      def initialize(name, options = {})
        @name = name
        @options = options
      end

      def as_json
        {
          "type" => "string"
        }
      end
    end
  end
end
