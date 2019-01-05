$(document).on('turbolinks:load', function(){
  admins_categories();
  minus_morderators();
  add_morderators();
  ban_users();
  unban_users();
});

async function admins_categories(){
  await $('table[role="datatable"].categories').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 2, 3, 4, 5, 6, 7, 8] }, 
        { 'bSearchable': false, 'aTargets': [ 2, 3, 4, 5, 6, 7, 8] }]
    });
  });
  await sleep(500);

  $('.link-remote').click(function(){
    $(this).parents('tr').addClass($(this).attr('id'));
  });
}

async function minus_morderators(){
  await $('.unload-minus-morderators').click(function(){
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

  let classes = $('.unload-minus-morderators').attr('class').replace("unload-", "");
  $('.unload-minus-morderators').attr('class', classes);
}

async function add_morderators(){
  await $('.unload-add-morderators').click(function(){
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

  let classes = $('.unload-add-morderators').attr('class').replace("unload-", "");
  $('.unload-add-morderators').attr('class', classes);
}

async function ban_users(){
  await $('.unload-ban-users').click(function(){
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

  let classes = $('.unload-ban-users').attr('class').replace("unload-", "");
  $('.unload-ban-users').attr('class', classes);
}

async function unban_users(){
  await $('.unload-unban-users').click(function(){
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

  let classes = $('.unload-unban-users').attr('class').replace("unload-", "");
  $('.unload-unban-users').attr('class', classes);
}
