$(document).on('turbolinks:load', function(){
  ban_users_topic();
  unban_users_topic();
});

async function ban_users_topic(){
  await $('.unload-topic_ban-users').click(function(){
    let obj = $(this);
    $.ajax({
      url: obj.data("source"),
    }).done(function(data){
      if(typeof(data) == "string"){
        $('.search-submit').click();
      } else {
        notification_ajax(data);
      }
    });
  });

  let classes = $('.unload-topic_ban-users').attr('class').replace("unload-", "");
  $('.unload-topic_ban-users').attr('class', classes);
}

async function unban_users_topic(){
  await $('.unload-topic_unban-users').click(function(){
    let obj = $(this);
    $.ajax({
      url: obj.data("source"),
    }).done(function(data){
      if(typeof(data) == "string"){
        $('.search-submit').click();
      } else {
        notification_ajax(data);
      }
    });
  });

  let classes = $('.unload-topic_unban-users').attr('class').replace("unload-", "");
  $('.unload-topic_unban-users').attr('class', classes);
}
