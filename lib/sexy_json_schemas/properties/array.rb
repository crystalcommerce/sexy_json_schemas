module SexyJSONSchemas
  module Properties
    class Array < Base
      type "array"

      def initialize(name, item_type, *args)
        super(name, *args)
        @item_type = item_type
      end

      def as_json
        super.tap do |json|
          json['items'] = { 'type' => @item_type.to_s }
        end
      end
    end
  end
end
