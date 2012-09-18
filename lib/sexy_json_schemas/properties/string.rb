module SexyJSONSchemas
  module Properties
    class String < Base
      type "string"

      def as_json
        super.tap do |json|
          if @options[:enum]
            json['enum'] = @options[:enum]
          end
        end
      end
    end
  end
end
