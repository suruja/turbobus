module TurbobusHelper
  def turbobus_include_tag
    javascript_tag "window.turbobusChannels = #{turbobus_channels.to_json};"
  end

  def turbobus_id_for(options={})
    case options
    when Hash
      channel = Turbobus::Helpers.channelize(
        options[:channel] || raise(ArgumentError, "Channel must be set.")
      )
      id = Turbobus::Helpers.channelize(channel, options[:id])
    else
      channel = Turbobus::Helpers.channelize(
        options || raise(ArgumentError, "Channel must be set.")
      )
      id = channel
    end
    turbobus_channels.add "/#{channel}"
    id
  end

  private
  def turbobus_channels
    @turbobus_channels ||= Set.new
  end
end
