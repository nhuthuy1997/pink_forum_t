$(document).on('turbolinks:load', function(){
  admins_tables();
  minus_morderators();
  add_morderators();
  ban_users();
  unban_users();
});

async function admins_tables(){
  await $('table[role="datatable"].categories').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 2, 3, 4, 5, 6, 7, 8] }, 
        { 'bSearchable': false, 'aTargets': [ 2, 3, 4, 5, 6, 7, 8] }]
    });
  });

  await $('table[role="datatable"].posts').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 5, 6, 7, 8, 9] }, 
        { 'bSearchable': false, 'aTargets': [ 3, 4, 5, 6, 7, 8, 9] }]
    });
  });

  await $('table[role="datatable"].topics').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 3, 4, 5, 6] }, 
        { 'bSearchable': false, 'aTargets': [ 3, 4, 5, 6] }]
    });
  });

  if($('.dataTables_wrapper').length){
    var check_link_remote = setInterval(link_remote, 1000);
    function link_remote(){
      if($('.link-remote').length) {
        clearInterval(check_link_remote);
        $('.link-remote').click(function(){
          $(this).parents('tr').addClass($(this).attr('id'));
        });
      }
    }
  }
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
