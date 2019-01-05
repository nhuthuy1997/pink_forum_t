$(document).ready(function () {
  // counter
  $(".counter").counterUp({
    delay: 100,
    time: 1200
  });

  var sparklineLogin = async function () {
    let cates_array = $('.cates-array').val().split("");
    let view_total = parseInt($('.view-total').val());
    let view_array = [];
    for(let i=0; i<5; i++){
      view_total -= parseInt(i * view_total / 5);
      view_array.push(view_total);
    }
    let posts_array = $('.post-bar').val().split("");
    $('#category-pie').sparkline(cates_array, {
      type: 'pie',
      height: '30',
      barWidth: '4',
      resize: true,
      barSpacing: '5',
      barColor: '#7ace4c'
    });

    $('#view-bar').sparkline(view_array, {
      type: 'bar',
      height: '30',
      barWidth: '4',
      resize: true,
      barSpacing: '5',
      barColor: '#7ace4c'
    });

    $('#post-bar').sparkline(posts_array, {
      type: 'bar',
      height: '30',
      barWidth: '4',
      resize: true,
      barSpacing: '5',
      barColor: '#7ace4c'
    });
  }

  var sparkResize;
  $(window).on("resize", function (e) {
    clearTimeout(sparkResize);
    sparkResize = setTimeout(sparklineLogin, 500);
  });
  sparklineLogin();
});
