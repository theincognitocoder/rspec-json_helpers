# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = 'rspec-json_helpers'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.summary       = 'RSpec helpers for working with JSON values.'
  spec.authors       = ['The Incognito Coder']
  spec.email         = ['theincognitocoder@gmail.com']
  spec.homepage      = 'https://github.com/theincognitocoder/rspec-json_helpers'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']
  spec.files         = Dir['lib/**/*.rb']

  spec.metadata = {
    'bug_tracker_uri'   => 'https://github.com/theincognitocoder/rspec-json_helpers/issues',
    'changelog_uri'     => 'https://github.com/theincognitocoder/rspec-json_helpers/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/github/theincognitocoder/rspec-json_helpers/master',
    'homepage_uri'      => 'https://github.com/theincognitocoder/rspec-json_helpers',
    'source_code_uri'   => 'https://github.com/theincognitocoder/rspec-json_helpers',
  }

  spec.add_development_dependency('coveralls', '~> 0.8')
  spec.add_development_dependency('kramdown', '~> 1.16')
  spec.add_development_dependency('pry', '~> 0.11')
  spec.add_development_dependency('rake', '~> 12.3')
  spec.add_development_dependency('rspec', '~> 3.7')
  spec.add_development_dependency('rubocop', '~> 0.56')
  spec.add_development_dependency('semver-string', '~> 1.0')
  spec.add_development_dependency('yard', '~> 0.9')
  spec.add_development_dependency('yard-sitemap', '~> 1.0')
end
# rubocop:enable Metrics/BlockLength
