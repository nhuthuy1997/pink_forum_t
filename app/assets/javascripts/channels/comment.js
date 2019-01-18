var load_form, received_data;

jQuery(document).on('turbolinks:load', function() {
  var post_id, user_id;
  if (App.comment) {
    App.cable.subscriptions.remove(App.comment);
  }
  if ($('.post-info').length) {
    post_id = $('.post-info').data('post-id');
    user_id = $('.post-info').data('user-id');
    App.cable.subscriptions.remove;
    return App.comment = App.cable.subscriptions.create({
      channel: "CommentChannel",
      post_id: post_id
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if (post_id) {
          if (data["action"] == "destroy"){
            $(`#comment-box-${data["comment"]}`).parent().remove();
          }else if(data["action"] == "create"){
            received_data(data);
          }else{
            $(`.comment-${data["comment"]["id"]}`).children('p').text(data["comment"]["content"]);
            $(`.comment-${data["comment"]["id"]} .comment-meta textarea`).val('');
          }
        }
      },
      send_comment: function(content, post_id, parent_id) {
        return this.perform('send_comment', {
          content: content,
          post_id: post_id,
          parent_id: parent_id
        });
      }
    });
  }
});


received_data = async function(data) {
  await($.ajax({
    url: "/admins/posts/" + data["comment"]["post_id"] + "/comments/" + data["comment"]["id"]
  }));
  $(`.comment-${data["comment"]["parent_id"]} .comment-meta textarea`).val('');
  if(!data["comment"]["parent_id"]){
    $('textarea').last().val("");
  }
};
