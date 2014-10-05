class Fluent::AddInfoOutput < Fluent::Output
  Fluent::Plugin.register_output('addinfo', self)

  config_param :yaml,    :string, :default => nil
  config_param :field,   :string, :default => nil
  config_param :pattern, :string, :default => nil
  config_param :addkey,  :string, :default => "addkey"

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

    @reqexp = Regexp.new(@pattern)
  end

  def start
    super
  end

  def shutdown
    super
  end

  def emit(tag, es, chain)
    emit_tag = Proc.new {|tag| "#{tag}.addinfo" }

    es.each do |time,record|
      begin
        info = record[@field].match(@reqexp)
        record[@addkey] = @replacementMap[info[1]].to_s
      rescue
      end
      Fluent::Engine.emit(emit_tag, time, record)
    end

    chain.next
  end
end
