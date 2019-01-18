# jQuery(document).on 'turbolinks:load', ->
#   if $('.post-info').length
#     post_id = $('.post-info').data('post-id')
#     user_id = $('.post-info').data('user-id')

#   App.message = App.cable.subscriptions.create {
#       channel: "MessageChannel"
#       post_id: post_id
#     },
#     connected: ->
#       # Called when the subscription is ready for use on the server

#     disconnected: ->
#       # Called when the subscription has been terminated by the server

#     received: (data) ->
#       if post_id
#         div_tag = $('.'+data['classname'])
#         div_tag.append(data['comment'])
#         load_form()

#     send_message: (content, post_id, parent_id) ->
#       @perform 'send_message', content: content, post_id: post_id, parent_id: parent_id

#     load_form()

# load_form = ->
#   $('form.unload-comment').submit (e) ->
#     $this = $(this)
#     post_id = $this.data('post-id')
#     parent_id = $this.data('parent-id')
#     content = $this.children('div').children('textarea')
#     if $.trim(content.val()).length > 1
#       App.message.send_message content.val(), post_id, parent_id
#       content.val('')
#     e.preventDefault()
#     return false
#   $('form.unload-comment').removeClass('unload-comment')
