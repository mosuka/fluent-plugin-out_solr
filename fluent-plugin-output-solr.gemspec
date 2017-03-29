# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-output-solr"
  spec.version       = "0.4.5"
  spec.authors       = ["Minoru Osuka"]
  spec.email         = ["minoru.osuka@gmail.com"]

  spec.summary       = "Fluent output plugin for sending data to Apache Solr."
  spec.description   = "Fluent output plugin for sending data to Apache Solr. It support SolrCloud not only Standalone Solr."
  spec.homepage      = "https://github.com/mosuka/fluent-plugin-output-solr"

  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'fluentd', '~> 0.12.0'
  spec.add_runtime_dependency 'rsolr-cloud', '~> 1.1.0'
  spec.add_runtime_dependency 'rsolr', '~> 1.0.12'
  spec.add_runtime_dependency 'zk', '~> 1.9.5'

  spec.add_development_dependency 'bundler', '~> 1.14.6'
  spec.add_development_dependency 'rake', '~> 11.1.2'
  spec.add_development_dependency 'test-unit', '~> 3.1.5'
  spec.add_development_dependency 'minitest', '~> 5.8.3'
  spec.add_development_dependency 'webmock', '~> 1.22.3'
  spec.add_development_dependency 'zk-server', '~> 1.1.8'
end
