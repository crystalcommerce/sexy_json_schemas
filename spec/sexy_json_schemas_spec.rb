require 'spec_helper'

describe SexyJSONSchemas do
  class Money
    include SexyJSONSchemas

    schema "money" do
      integer_property "cents", :required => true
      string_property "currency"
    end
  end

  class Product
    include SexyJSONSchemas

    schema "product", :root_element => false do
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
end
