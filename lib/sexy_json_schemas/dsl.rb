module SexyJSONSchemas
  module DSL
    def schema(name, options = {}, &block)
      options[:root_element] ||= name unless options[:root_element] == false
      @schema_name      = name
      @schema_options   = options
      @definition_block = block
    end

    def schema_name
      @schema_name
    end

    def as_json
      definition = SchemaDefinition.new(@schema_name, @schema_options)
      definition.instance_eval(&@definition_block)
      definition.as_json
    end
  end
end
