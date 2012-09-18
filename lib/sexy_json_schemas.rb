module SexyJSONSchemas
  def self.included(receiver)
    receiver.extend(DSL)
  end
end

require 'sexy_json_schemas/dsl'
require 'sexy_json_schemas/schema_definition'
require 'sexy_json_schemas/properties/base'
require 'sexy_json_schemas/properties/integer'
require 'sexy_json_schemas/properties/number'
require 'sexy_json_schemas/properties/boolean'
require 'sexy_json_schemas/properties/null'
require 'sexy_json_schemas/properties/string'
require 'sexy_json_schemas/properties/any'
require 'sexy_json_schemas/properties/union'
require 'sexy_json_schemas/properties/array'
require 'sexy_json_schemas/properties/object'
