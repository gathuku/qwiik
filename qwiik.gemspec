require_relative 'lib/qwiik/version'

Gem::Specification.new do |spec|
  spec.name          = "qwiik"
  spec.version       = Qwiik::VERSION
  spec.authors       = ["Moses Gathuku"]
  spec.email         = ["mosesgathuku95@gmail.com"]

  spec.summary       = %q{A gem for connecting with daraja 2.0}
  spec.description   = %q{A simple Mpesa daraja Gem}
  spec.homepage      = "https://github.com/gathuku/qwiik"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://rubygems.org'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gathuku/qwiik"
  spec.metadata["changelog_uri"] = "https://github.com/gathuku/qwiik"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # gem.add_dependency 'faraday', '~> 0.17.0'
  # gem.add_dependency 'json', '~> 2.2'
  # gem.add_dependency 'webmock', '~> 3.7', '>= 3.7.6'

end
