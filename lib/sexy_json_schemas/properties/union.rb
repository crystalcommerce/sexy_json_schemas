module SexyJSONSchemas
  module Properties
    class Union < Base
      def initialize(name, types, *args)
        super(name, *args)
        @types = types
      end

      def type
        @types.map(&:to_s)
      end
    end
  end
end
