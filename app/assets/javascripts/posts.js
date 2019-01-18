$(document).on('turbolinks:load', function(){
  toggle_topics();
  checkScore();

  $('#category_id').click(function() {
    toggle_topics();
  });
});

function toggle_topics(){
  $('.topic-hide').hide();
  $('.topic-hide').prop('disabled', true);
  let category_id = $('#category_id').val();
  $(`.topic-${category_id}`).prop('disabled', false);
  $(`.topic-${category_id}`).show();
}

function checkScore() {
  let color = '';
  let scoreVal = $('#scoreCounter').text();
  if (scoreVal < 0) {
    color = "#FF586C";
  } else if (scoreVal > 0) {
    color = "#6CC576";
  } else {
    color = "#666666";
  }
  $('#scoreCounter').css('color', color);
}
