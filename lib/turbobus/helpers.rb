module Turbobus
  class Helpers
    class << self
      def channelize(*args)
        [args].flatten.compact.map(&:to_param).join(':')
      end
    end
  end
end
