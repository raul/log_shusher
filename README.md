# Log Shusher

Silence your Rails logs under certain conditions.

![](https://raw.githubusercontent.com/raul/log_shusher/master/shusher.jpg)

## Installation

Add the gem to your `Gemfile`:

```ruby
gem 'log_shusher'
```

and run

```bash
bundle
```

## Usage

Add the following code in an initializer (e.g: `config/initializers/log_shusher.rb`) or in an environment configuration file (e.g: `config/environments/development.rb`):

```ruby
LogShusher.shush do |env|
   # expression
end
```

The `env` parameter is the [Rack environment hash](http://rack.rubyforge.org/doc/SPEC.html) corresponding to the current request. The request will be logged if the expression inside the block evaluates to `nil` or `false`.

Examples:

```ruby
# Don't log any request
LogShusher.shush do |env|
  true
end

# Don't log asset requests
LogShusher.shush do |env|
  env['PATH_INFO'].to_s.include? '/assets/'
end

# Don't log requests for certain file extensions
LogShusher.shush do |env|
  exts = %w{ .ico .js .css .gif .png .jpeg .jpg }
  exts.any? { |ext| env['PATH_INFO'].to_s.ends_with?(ext) }
end
```

## License

Released under the MIT License, Copyright (c) 2014 - To infity... and beyond! Raúl Murciano.
