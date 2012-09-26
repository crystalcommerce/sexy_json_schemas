module SexyJSONSchemas
  module Properties
    class Base
      attr_reader :name

      def initialize(name, options = {})
        @name = name
        @options = options
      end

      def type
        nil
      end

      def as_json
        json = { }

        json["type"] = type if type

        if @options[:required]
          json['required'] = true
        end

        if @options[:enum]
          json['enum'] = @options[:enum]
        end

        if @options[:format]
          json['format'] = @options[:format]
        end

        if @options[:description]
          json['description'] = @options[:description]
        end

        json
      end
    end
  end
end
