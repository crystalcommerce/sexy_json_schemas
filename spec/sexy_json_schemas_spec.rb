require 'spec_helper'

JSONTestClass = Class.new {
  include SexyJSONSchemas
}

shared_examples_for "valid schema generator" do
  its(:as_json) { should be_valid_json_schema }
end

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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
  end

  describe "array properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        array_property "colors",
                       :enum => [['blue', true], ['red', false], ['green', true]],
                       :required => true do
          string_property :enum => %w[blue red green]
          boolean_property
        end
        array_property "sizes" do
          integer_property :enum => [1,2,3,4,5,6]
        end
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "colors" => {
          "type" => "array",
          "required" => true,
          "enum" => [['blue', true], ['red', false], ['green', true]],
          "items" => [
            {
              "type" => "string",
              "enum" => %w[blue red green]
            },
            {
              "type" => "boolean"
            }
          ]
        },
        "sizes" => {
          "type" => "array",
          "items" => {
              "type" => "integer",
              "enum" => [1,2,3,4,5,6]
          }
        }
      }
    }}

    it_should_behave_like "valid schema generator"
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

    it_should_behave_like "valid schema generator"
  end

  describe "$ref properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        ref_property "money", "http://example.com/money.json"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "money" => {
          "$ref" => "http://example.com/money.json"
        }
      }
    }}

    it_should_behave_like "valid schema generator"
  end
end
