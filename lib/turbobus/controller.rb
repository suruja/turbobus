module Turbobus
  module Controller
    def self.included(base)
      base.send(:helper_method, :turbobus)
    end

    def turbobus(channel, opts)
      key = [channel].flatten.compact.map(&:to_param).join(':')
      MessageBus.publish "/#{key}", {
        partial: render_to_string(opts),
        change: key
      }
    end
  end
end