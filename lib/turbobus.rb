require 'turbobus/version'
require 'turbobus/controller'

module Turbobus
  module Rails
    class Engine < ::Rails::Engine
      require 'message_bus'
    end
  end
end
