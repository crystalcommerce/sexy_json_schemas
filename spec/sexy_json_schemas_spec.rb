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
      string_property "currency", :description => "ISO currency code"
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
                "type" => "string",
                "description" => "ISO currency code"
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
        string_property "when", :format => 'date-time'
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "silly" => {
          "type" => "string"
        },
        "when" => {
          "format" => "date-time",
          "type" => "string"
        }
      }
    }}

    it_should_behave_like "valid schema generator"
  end

  describe "number properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        number_property "beast", :minimum => 0,
                                 :maximum => 100
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "beast" => {
          "type" => "number",
          "minimum" => 0,
          "maximum" => 100
        }
      }
    }}

    it_should_behave_like "valid schema generator"
  end

  describe "integer properties" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => false do
        integer_property "cromulent", :minimum => 0, :maximum => 100
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "cromulent" => {
          "type" => "integer",
          "minimum" => 0,
          "maximum" => 100
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

        array_property "suppliers" do
          ref_property "http://example.com/supplier.json"
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
        "suppliers" => {
          "type" => "array",
          "items" => {
            "$ref" => "http://example.com/supplier.json"
          }
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
        ref_property "money", "http://example.com/money.json",
                              :description => "Fun"
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "money" => {
          "$ref" => "http://example.com/money.json",
          "description" => "Fun"
        }
      }
    }}

    it_should_behave_like "valid schema generator"
  end

  describe "overriding root element" do
    subject { Class.new(JSONTestClass) {
      schema "void", :root_element => "wat" do
      end
    }}

    its(:as_json) { should == {
      "name" => "void",
      "type" => "object",
      "properties" => {
        "wat" => {
          "type" => "object",
          "properties" => {}
        }
      }
    }}

    it_should_behave_like "valid schema generator"
  end

  describe "dynamic calls in schema definition" do
    before(:each) do

    end
    subject { }

    it "dynamically calls the schema" do
      global_var = "bob"
      subject = Class.new(JSONTestClass) {
        schema "void", :root_element => "wat" do
          ref_property "name", global_var
        end
      }
      subject.as_json['properties']['wat']['properties']['name'].
        should == {"$ref" => "bob"}

      global_var = "fred"

      subject.as_json['properties']['wat']['properties']['name'].
        should == {"$ref" => "fred"}
    end
  end
end
