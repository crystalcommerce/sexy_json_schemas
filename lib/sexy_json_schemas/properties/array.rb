module SexyJSONSchemas
  module Properties
    class Array < Base
      def self.define_property_delegator(property)
        define_method(property) do |*args|
          blank_object = Properties::AnonymousObject.new
          blank_object.send(property, '', *args)
          @item_schemas << blank_object
        end
      end

      Properties::Object.property_methods.each do |property|
        define_property_delegator(property)
      end

      type "array"

      def initialize(*args, &block)
        super(*args)
        @item_schemas = []

        instance_eval(&block) if block_given?
      end


      def as_json
        super.tap do |json|
          json['items'] = items_json
        end
      end

      def items_json
        if @item_schemas.length == 0
          {}
        elsif @item_schemas.length == 1
          @item_schemas.first.as_json
        else
          @item_schemas.map(&:as_json)
        end
      end
    end
  end
end
