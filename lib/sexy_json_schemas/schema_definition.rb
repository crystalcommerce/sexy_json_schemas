module SexyJSONSchemas
  class SchemaDefinition
    attr_reader :name, :options

    def initialize(name, options)
      @name = name
      @options = options
      @properties = []
    end

    def as_json
        json = {
          "name" => name,
          "type" => "object",
          "properties" => {}
        }


        if @options.fetch(:root_element, true)
          json["properties"][name] = {
            "type" => "object",
            "properties" => properties
          }
        else
          json["properties"] = properties
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
