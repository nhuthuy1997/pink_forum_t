$(document).on('turbolinks:load', function(){
  $('[data-toggle="collapse"]').on('click', function() {
    var $this = $(this),
      $parent = typeof $this.data('parent')!== 'undefined' ? $($this.data('parent')) : undefined;
    if($parent === undefined) { /* Just toggle my  */
      $this.find('.fa').toggleClass('fa-plus fa-minus');
      return true;
    }

    /* Open element will be close if parent !== undefined */
    var currentIcon = $this.find('.fa');
    currentIcon.toggleClass('fa-plus fa-minus');
    $parent.find('.fa').not(currentIcon).removeClass('fa-minus').addClass('fa-plus');
  });
});
