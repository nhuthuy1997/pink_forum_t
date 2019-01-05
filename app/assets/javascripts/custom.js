function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function notification_ajax(data){
  $.toast({
    text: data['message'],
    position: 'top-right',
    loaderBg: '#fff',
    icon: data['icon'],
    hideAfter: 3500,
    stack: 6
  });
}
