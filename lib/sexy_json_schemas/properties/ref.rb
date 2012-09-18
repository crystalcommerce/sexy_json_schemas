module SexyJSONSchemas
  module Properties
    class Ref < Base
      def initialize(name, schema, options = {})
        super(name, options) 
        @schema = schema
      end

      def as_json
        {"$ref" => @schema}
      end
    end
  end
end
