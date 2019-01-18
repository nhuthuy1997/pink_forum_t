jQuery(document).on 'turbolinks:load', ->
  if !App.notification
    App.notification = App.cable.subscriptions.create "NotificationChannel",
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $('.notification-box ul').append(data['notification'])
        $('.notification-counter').text($('.unread').length);

      send_notification: ->
        @perform 'send_notification'
