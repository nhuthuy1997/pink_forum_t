$(document).on('turbolinks:load', function(){
  $('.unread').click(async function(event){
    event.preventDefault();
    await $(`.${$(this).data('submit')}`).click();
    await(500);
  });

  $('.notification-counter').text($('.unread').length);
});
