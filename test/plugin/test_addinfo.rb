require 'helper'

class AddInfoOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    yaml test/hoge.yaml
    field path
    pattern [^-]*-[^-]*-(.*)
    addkey newkey
  ]

  def create_driver(conf = CONFIG, tag='test')
    Fluent::Test::OutputTestDriver.new(Fluent::AddInfoOutput, tag).configure(conf)
  end

  def test_configure
    assert_raise(Fluent::ConfigError) {
      d = create_driver('')
    }

    assert_raise(Fluent::ConfigError) {
      d = create_driver(%[
        field test_field
        pattern test_pattern
      ])
    }

    assert_raise(Fluent::ConfigError) {
      d = create_driver(%[
        yaml test/hoge.yaml
        pattern test_pattern
      ])
    }

    assert_raise(Fluent::ConfigError) {
      d = create_driver(%[
        yaml test/hoge.yaml
        field test_field
      ])
    }

    assert_raise(Fluent::ConfigError) {
      d = create_driver(%[
        yaml test/hoge
        field test_field
        pattern test_pattern
      ])
    }

    d = create_driver %[
      yaml test/hoge.yaml
      field test_field
      pattern test_pattern
    ]

    #### check configurations
    assert_equal 'test/hoge.yaml', d.instance.yaml
    assert_equal 'test_field', d.instance.field
    assert_equal 'test_pattern', d.instance.pattern
    assert_equal 'addkey', d.instance.addkey
  end

  def test_emit
    d = create_driver

    d.run do
      d.emit({"path" => "aaa-aaa-aaa", "path2" => "aaa-aaa-aaa"})
      d.emit("aaa" => "aaa-aaa-aaa")
      d.emit("path" => "aaa-aaa")
    end
    assert_equal [
      {"path" => "aaa-aaa-aaa", "path2" => "aaa-aaa-aaa", "newkey" => "111"},
      {"aaa" => "aaa-aaa-aaa"},
      {"path" => "aaa-aaa"}
    ], d.records

  end
end
