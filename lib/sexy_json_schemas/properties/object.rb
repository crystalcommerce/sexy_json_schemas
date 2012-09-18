module SexyJSONSchemas
  module Properties
    class Object < Base
      type "object"

      def initialize(name, options = {}, &block)
        super(name, options)
        @properties = []
        instance_eval(&block) if block_given?
      end

      def as_json
        super.tap do |json|
          json["properties"] = properties
        end
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
