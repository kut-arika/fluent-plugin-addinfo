# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-addinfo"
  spec.version       = "0.0.1"
  spec.authors       = ["Akira Otsuka"]
  spec.email         = ["kut.arika.1114@gmail.com"]
  spec.summary       = %q{add infomation from csv}
  spec.description   = %q{add infomation from csv}
  spec.homepage      = ""
  spec.license       = "APLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "fluentd"
  spec.add_runtime_dependency "fluentd"
end
