module Turbobus
  module Controller
    def self.included(base)
      base.send(:helper_method, :turbobus)
    end

    def turbobus(opts={})
      channel = Turbobus::Helpers.channelize(opts[:channel])
      MessageBus.publish "/#{channel}", { change: channel }.merge(
        opts[:path] ?
        { path: opts[:path] } :
        { partial: render_to_string(partial: opts[:partial]) }
      )
    end
  end
end
