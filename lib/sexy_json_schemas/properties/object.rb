module SexyJSONSchemas
  module Properties
    class Object
      attr_reader :name

      def initialize(name, options = {}, &block)
        @name = name
        @options = options
        @properties = []
        instance_eval(&block)
      end

      def as_json
        json = {
          "type" => "object",
          "properties" => properties
        }

        if @options[:required]
          json['required'] = true
        end

        json
      end

      def properties
        @properties.each_with_object({}) do |property, acc|
          acc[property.name] = property.as_json
        end
      end

      def integer_property(*args)
        @properties << Properties::Integer.new(*args)
      end

      def string_property(*args)
        @properties << Properties::String.new(*args)
      end

      def object_property(*args, &block)
        @properties << Properties::Object.new(*args, &block)
      end
    end
  end
end
