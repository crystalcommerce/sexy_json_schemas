module SexyJSONSchemas
  class SchemaDefinition
    extend Forwardable

    attr_reader :name

    def_delegators :@core_object,
                    *Properties::Object.property_methods

    def initialize(name, options)
      @name        = name
      @root_element = options.fetch(:root_element, true)
      @core_object = Properties::Object.new(name, options)
    end

    def as_json
      json = @core_object.as_json

      if root_element?
        json = wrap_in_root(json)
      end

      json['name'] = name

      json
    end

    private

    def properties
      @core_object.as_json
    end

    def root_element?
      @root_element
    end

    def wrap_in_root(json)
      {
        "type" => "object",
        "properties" => {
          name => json
        }
      }
    end
  end
end
