require 'spec_helper'

JSONTestClass = Class.new {
  include SexyJSONSchemas
}

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

  describe "null properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        null_property "nope"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "nope" => {
          "type" => "null"
        }
      }
    }}
  end

  describe "string properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        string_property "silly"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "silly" => {
          "type" => "string"
        }
      }
    }}
  end

  describe "number properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        number_property "beast"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "beast" => {
          "type" => "number"
        }
      }
    }}
  end

  describe "integer properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        integer_property "cromulent"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "cromulent" => {
          "type" => "integer"
        }
      }
    }}
  end

  describe "any properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        any_property "enlightened"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "enlightened" => {
          "type" => "any"
        }
      }
    }}
  end

  describe "boolean properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        boolean_property "robot"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "robot" => {
          "type" => "boolean"
        }
      }
    }}
  end

  describe "union properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        union_property "teachers", [:string, :null]
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "teachers" => {
          "type" => ["string", "null"]
        }
      }
    }}
  end

  describe "array properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        array_property "colors", :string
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "colors" => {
          "type" => "array",
          "items" => {
            "type" => "string"
          }
        }
      }
    }}
  end

  describe "object properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        object_property "attributes", :required => true do
          string_property "color", :enum => %w[red blue green]
        end
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
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
    }}
  end
end
