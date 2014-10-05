class Fluent::AddInfoOutput < Fluent::Output
  Fluent::Plugin.register_output('addinfo', self)

  config_param :yaml,    :string, :default => nil
  config_param :field,   :string, :default => nil
  config_param :pattern, :string, :default => nil

  def initialize
    super
    require 'yaml'
  end

  def configure(conf)
    super

    if not @yaml or not @field or not @pattern
      raise Fluent::ConfigError, "each of yaml and field and pattern must be specified"
    end

    begin
      @replacementMap = YAML.load_file(@yaml)
    rescue => e
      raise Fluent::ConfigError, e
    end

    reqexp = Regexp.new(@pattern)
  end

  def start
    super
  end

  def shutdown
    super
  end

  def format(tag, time, record)
    [tag, time, record].to_msgpack
  end

  def write(chunk)
    records = []
    chunk.msgpack_each { |record|
      # records << record
    }
    # write records
  end
end
