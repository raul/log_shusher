# Requests will be logged if the following block evaluates to nil or false:
#
# LogShusher.shush do |env|
#   # ...
# end

module LogShusher
  extend self
  attr_accessor :shush_condition

  def shush(&block)
    self.shush_condition = block
    shush_rails
    shush_rack
  end

  def shush?(env)
    self.shush_condition.call env
  end

  private

  # Sets Rails.logger.level to ERROR when .shush? returns true
  def shush_rails
    ::Rails::Rack::Logger.class_eval do
      def call_app_with_shushed_logs(request, env)
        logger_level = Rails.logger.level
        Rails.logger.level = Logger::ERROR if LogShusher.shush?(env)
        call_app_without_shushed_logs(request, env).tap do
          Rails.logger.level = logger_level
        end
      end

      alias_method_chain :call_app, :shushed_logs
    end
  end

  # Skips Rack logging when .shush? returns true
  def shush_rack
    ::Rack::CommonLogger.class_eval do
      def call_with_shushed_logs(env)
        if LogShusher.shush?(env)
          @app.call(env)
        else
          call_without_shushed_logs(env)
        end
      end

      alias_method_chain :call, :shushed_logs
    end
  end
end
