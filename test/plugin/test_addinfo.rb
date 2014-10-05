require 'helper'

class AddInfoOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    yaml test/hoge.yaml
    field path
    pattern [^-]*-[^-]*-(.*)
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
  end

  def test_format
    d = create_driver

    # time = Time.parse("2011-01-02 13:14:15 UTC").to_i
    # d.emit({"a"=>1}, time)
    # d.emit({"a"=>2}, time)

    # d.expect_format %[2011-01-02T13:14:15Z\ttest\t{"a":1}\n]
    # d.expect_format %[2011-01-02T13:14:15Z\ttest\t{"a":2}\n]

    # d.run
  end

  def test_write
    d = create_driver

    # time = Time.parse("2011-01-02 13:14:15 UTC").to_i
    # d.emit({"a"=>1}, time)
    # d.emit({"a"=>2}, time)

    # ### FileOutput#write returns path
    # path = d.run
    # expect_path = "#{TMP_DIR}/out_file_test._0.log.gz"
    # assert_equal expect_path, path
  end
end
