Gem::Specification.new do |spec|
  spec.name     = 'log_shusher'
  spec.version  = '1.0'
  spec.summary  = 'Silence your Rails logs under certain conditions.'
  spec.homepage = 'https://github.com/raul/log_shusher'
  spec.author   = 'Raul Murciano'
  spec.email    = 'raul@murciano.net'
  spec.licenses    = ['MIT']
  spec.files = %w(
    log_shusher.gemspec
    README.md
    MIT-LICENSE
    lib/log_shusher.rb
  ) + Dir['lib/*.rb']
end
