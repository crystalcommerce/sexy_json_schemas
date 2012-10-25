module SexyJSONSchemas
  module Properties
    class Ref < Base
      def initialize(name, schema, options = {})
        super(name, options) 
        @schema = schema
      end

      def as_json
        json = { "$ref" => @schema }

        if @options[:description]
          json['description'] = @options[:description]
        end

        json
      end
    end
  end
end
