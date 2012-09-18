module SexyJSONSchemas
  module Properties
    class Number < Base
      def type
        "number"
      end

      def as_json
        super.tap do |json|
          if @options[:minimum]
            json['minimum'] = @options[:minimum]
          end

          if @options[:maximum]
            json['maximum'] = @options[:maximum]
          end
        end
      end
    end
  end
end
