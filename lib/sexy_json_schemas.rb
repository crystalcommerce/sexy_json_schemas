module SexyJSONSchemas
  def self.included(receiver)
    receiver.extend(DSL)
  end
end

require 'sexy_json_schemas/dsl'
require 'sexy_json_schemas/schema_definition'
require 'sexy_json_schemas/properties/integer'
require 'sexy_json_schemas/properties/string'
