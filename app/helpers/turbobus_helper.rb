module TurbobusHelper
  def turbobus_include_tag
    @turbobus_channels ||= Set.new
    javascript_tag "window.turbobusChannels = #{@turbobus_channels.to_json};"
  end

  def turbobus_id_for(array, ext=[])
    key = array.flatten.compact.map(&:to_param).join(':')
    @turbobus_channels ||= Set.new
    @turbobus_channels.add "/#{key}"
    [key, [ext].flatten.map(&:to_param).join(':')].compact.join(':')
  end
end
