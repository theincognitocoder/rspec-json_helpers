# frozen_string_literal: true

desc 'Runs the test suite'
task 'test' => [
  'test:clean',
  'test:spec',
]

task 'test:clean' do
  rm_rf('coverage')
end

task 'test:spec' do
  sh('bundle exec rspec')
end
