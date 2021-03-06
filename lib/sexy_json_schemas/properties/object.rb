module SexyJSONSchemas
  module Properties
    class Object < Base
      def type
        "object"
      end

      def self.property_methods
        [
          :integer_property,
          :string_property,
          :object_property,
          :number_property,
          :boolean_property,
          :null_property,
          :any_property,
          :union_property,
          :array_property,
          :ref_property
        ]
      end

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
        @properties.inject({}) do |acc, property|
          acc[property.name] = property.as_json
          acc
        end
      end

      def integer_property(*args, &block)
        @properties << Properties::Integer.new(*args, &block)
      end

      def number_property(*args, &block)
        @properties << Properties::Number.new(*args, &block)
      end

      def boolean_property(*args, &block)
        @properties << Properties::Boolean.new(*args, &block)
      end

      def null_property(*args, &block)
        @properties << Properties::Null.new(*args, &block)
      end

      def string_property(*args, &block)
        @properties << Properties::String.new(*args, &block)
      end

      def any_property(*args, &block)
        @properties << Properties::Any.new(*args, &block)
      end

      def union_property(*args, &block)
        @properties << Properties::Union.new(*args, &block)
      end

      def array_property(*args, &block)
        @properties << Properties::Array.new(*args, &block)
      end

      def ref_property(*args, &block)
        @properties << Properties::Ref.new(*args, &block)
      end

      def object_property(*args, &block)
        @properties << Properties::Object.new(*args, &block)
      end
    end
  end
end
