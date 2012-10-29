# SexyJSONSchemas

A DSL for generating JSON Schemas.

Based on draft 3 of the [zyp-json-schema](http://tools.ietf.org/id/draft-zyp-json-schema-03.html).

## Installation

Add this line to your application's Gemfile:

    gem 'sexy_json_schemas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sexy_json_schemas

## Usage

A simple customer schema:

    module Api::V1::Schemas
      module Customer
        include SexyJSONSchemas
        extend self
    
        def schema_name
          "customer"
        end
    
        schema "customer" do
          integer_property "id", :minimum => 0, :required => true
          string_property "email", :required => true
          string_property "fullname", :required => true
          string_property "created_at", :required => true, :format => "date-time"
          string_property "updated_at", :required => true, :format => "date-time"
          string_property "logged_in_at", :format => "date-time"
          string_property "phone"
          ref_property "store_credit", "https://apitest-api.crystalcommerce.com/v1/schemas/money#"
          string_property "notes"
          string_property "locale"
          string_property "membership_number"
        end
      end
    end

And the call to `Api::V1::Schemas::Customer.as_json` will generate a
schema like:

    {
      "name": "customer",
      "type": "object",
      "properties": {
        "customer": {
          "type": "object",
          "properties": {
            "created_at": {
              "required": true,
              "format": "date-time",
              "type": "string"
            },
            "dynamic_attributes": {
              "type": "object",
              "properties": {
                
              }
            },
            "notes": {
              "type": "string"
            },
            "store_credit": {
              "$ref": "https:\/\/apitest-api.crystalcommerce.com\/v1\/schemas\/money#"
            },
            "updated_at": {
              "required": true,
              "format": "date-time",
              "type": "string"
            },
            "fullname": {
              "required": true,
              "type": "string"
            },
            "id": {
              "required": true,
              "type": "integer",
              "minimum": 0
            },
            "phone": {
              "type": "string"
            },
            "logged_in_at": {
              "format": "date-time",
              "type": "string"
            },
            "locale": {
              "type": "string"
            },
            "membership_number": {
              "type": "string"
            },
            "email": {
              "required": true,
              "type": "string"
            }
          }
        }
      }
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
