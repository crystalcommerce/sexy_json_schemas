require 'rspec/expectations'
require 'require_relative'
require 'json-schema'
require 'json'

module JSONValidatorMatchers
  extend RSpec::Matchers::DSL

  META_SCHEMA = JSON.parse(File.read(File.join(File.dirname(__FILE__),
                                               'json_schema.schema')))

  matcher :be_valid_json_schema do
    match do |generated_schema|
      JSON::Validator.validate(META_SCHEMA, generated_schema)
    end

    failure_message_for_should do |schema|
      errors = JSON::Validator.fully_validate(META_SCHEMA, schema)
      "expected no validation errors but got:\n  #{errors.join("\n  ")}"
    end

    failure_message_for_should_not do |schema|
      "expected validation errors but got none"
    end
  end
end
