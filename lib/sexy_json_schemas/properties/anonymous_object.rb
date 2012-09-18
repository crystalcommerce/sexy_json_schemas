module SexyJSONSchemas
  module Properties
    class AnonymousObject < Properties::Object
      def initialize
        super(nil)
      end

      def as_json
        @properties.inject({}) do |acc, property|
          acc.merge(property.as_json)
        end
      end
    end
  end
end
