//= require message-bus
//= require_self

$(document).on("ready", function() {
  MessageBus.start();
  MessageBus.callbackInterval = 500;
});


$(document).on("ready page:load", function(event) {
  var i, len;
  MessageBus.unsubscribe("*");

  for (i = 0, len = window.turbobusChannels.length; i < len; i++) {
    MessageBus.subscribe(window.turbobusChannels[i], function(opts) {
      if (opts.path) {
        $.ajax({
          url: opts.path,
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          success: function(data) {
            Turbolinks.replace(data, { change: opts.change });
          }
        });
      } else {
        Turbolinks.replace(opts.partial, { change: opts.change });
      }
    });
  }
});
