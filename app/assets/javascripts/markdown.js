$(document).on('turbolinks:load', function(){
  load_markdown();
});

let load_markdown = async () => {
  if($('#markdown').length) {
    var simple_mde = new SimpleMDE({ 
      toolbar: [
        "bold", "italic", "strikethrough", "heading-1", "heading-2", "heading-3", "|",
        "code", "quote", "unordered-list", "ordered-list", "table", "horizontal-rule", "clean-block", "|",
        "link", 
        {
          name: "image",
          action: uploader,
          className: "fa fa-picture-o",
          title: "Insert Image",
        }, "|",
        "preview", "side-by-side", "fullscreen",
      ],
      spellChecker: false,
      element: document.getElementById("markdown") 
    });
  }
}

let uploader = async (editor) => {
  window['editor'] = editor;
  await insert_image(editor);
  await $('.unload[src!=""]').removeClass('unload');
  await media_dropzone(editor);
  $('#images-modal').modal('show');
}

let insert_image = (editor) => {
  $('.unload').click(function(){
    let cm = editor.codemirror;
    let output = '';
    let text = $(this).prop('src');
    output = '![](' + text + ')';
    cm.replaceSelection(output);
    $('#images-modal').modal('hide');
  });
}

let media_dropzone = (editor) => {
  initDropzones()
  var mediaDropzone = new Dropzone("#media-dropzone");
  return mediaDropzone.on("success", function(file, responseText) {
    var clone = $('.clone:hidden').clone();
    clone.find('img').attr('src', responseText.link["url"]);
    clone.css('display', 'block');
    clone.appendTo('.gallery');
    insert_image(editor);
    $('.unload[src!=""]').removeClass('unload');
  });
}

function initDropzones() {
  $('#media-dropzone').each(function () {
    let dropzoneControl = $(this)[0].dropzone;
    if (dropzoneControl) {
      dropzoneControl.destroy();
    }
  });
}
