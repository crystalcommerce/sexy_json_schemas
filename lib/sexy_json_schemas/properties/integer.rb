module SexyJSONSchemas
  module Properties
    class Integer
      attr_reader :name

      def initialize(name, options = {})
        @name    = name
        @options = options
      end

      def as_json
        json = {
          "type" => "integer"
        }
        json["required"] = true if @options[:required]

        json
      end
    end
  end
end
