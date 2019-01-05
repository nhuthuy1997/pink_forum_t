$(document).on('turbolinks:load', function(){
  admins_posts();
});

async function admins_posts(){
  await $('table[role="datatable"].posts').each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      'aoColumnDefs': [{ 'bSortable': false, 'aTargets': [ 3, 4, 5, 6, 7, 8, 9] }, 
        { 'bSearchable': false, 'aTargets': [ 3, 4, 5, 6, 7, 8, 9] }]
    });
  });
  await sleep(500);
}
