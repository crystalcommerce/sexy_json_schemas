module SexyJSONSchemas
  class SchemaDefinition
    attr_reader :name, :options

    def initialize(name, options)
      @name = name
      @options = options
      @properties = []
    end

    def as_json
      {
        "name" => name,
        "type" => "object",
        "properties" => {
          name => {
            "type" => "object",
            "properties" => properties
          }
        }
      }
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
  end
end
