module SexyJSONSchemas
  module DSL
    def schema(name, options = {}, &block)
      options[:root_element] ||= name unless options[:root_element] == false
      @schema_name = name
      @definition = SchemaDefinition.new(name, options)
      @definition.instance_eval(&block)
    end

    def schema_name
      @schema_name
    end

    def as_json
      @definition.as_json
    end
  end
end
