$(document).on('turbolinks:load', function(){
  admins_topics();
  ban_users_topic();
  unban_users_topic();
});

async function admins_topics(){
  await $('table[role="datatable"].topics').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 3, 4, 5, 6] }, 
        { 'bSearchable': false, 'aTargets': [ 3, 4, 5, 6] }]
    });
  });
  await sleep(500);
}

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
