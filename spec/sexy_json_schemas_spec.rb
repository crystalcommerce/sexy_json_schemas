require 'spec_helper'

describe SexyJSONSchemas do
  class Money
    include SexyJSONSchemas

    schema "money" do
      integer_property "cents", :required => true
      string_property "currency"
    end
  end

  describe Money do
    subject { Money }

    its(:schema_name) { should == "money" }
    its(:as_json) do
      should == {
        "name" => "money",
        "type" => "object",
        "properties" => {
          "money" => {
            "type" => "object",
            "properties" => {
              "cents" => {
                "type" => "integer",
                "required" => true
              },
              "currency" => {
                "type" => "string"
              }
            }
          }
        }
      }
    end
  end

  class Product
    include SexyJSONSchemas

    schema "producto", :root_element => false do
      string_property "name"

      object_property "attributes", :required => true do
        string_property "color", :enum => %w[red blue green]
      end

      number_property "weight"

      boolean_property "is_preorder"

      null_property "spaceghost"

      any_property "whatever"

      union_property "maybe", [:null, :boolean]

      array_property "links", :string
    end
  end

  describe Product do
    subject { Product }

    its(:schema_name) { should == "producto" }

    its(:as_json) do
      should == {
        "name" => "producto",
        "type" => "object",
        "properties" => {
          "name" => {
            "type" => "string"
          },
          "weight" => {
            "type" => "number"
          },
          "is_preorder" => {
            "type" => "boolean"
          },
          "spaceghost" => {
            "type" => "null"
          },
          "whatever" => {
            "type" => "any"
          },
          "maybe" => {
            "type" => ['null', 'boolean']
          },
          "links" => {
            "type" => "array",
            "items" => {
              "type" => "string"
            }
          },
          "attributes" => {
            "type" => "object",
            "required" => true,
            "properties" => {
              "color" => {
                "type" => "string",
                "enum" => %w[red blue green]
              }
            }
          }
        }
      }
    end
  end
end
