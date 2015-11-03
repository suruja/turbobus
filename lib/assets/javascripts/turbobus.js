//= require message-bus
//= require_self

$(document).on("ready", function() {
  MessageBus.start();
  MessageBus.callbackInterval = 500;
});

$(document).on("ready page:load", function(event) {
  var channel, i, len;
  MessageBus.unsubscribe("*");
  for (i = 0, len = window.turbobusChannels.length; i < len; i++) {
    channel = window.turbobusChannels[i];
    MessageBus.subscribe(channel, function(data) {
      Turbolinks.replace(data.partial, data);
    });
  }
});
