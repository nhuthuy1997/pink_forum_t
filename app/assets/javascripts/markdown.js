$(document).on('turbolinks:load', function(){
  var simplemde = new SimpleMDE({ 
    toolbar: [
      "bold", "italic", "strikethrough", "heading-1", "heading-2", "heading-3", "|",
      "code", "quote", "unordered-list", "ordered-list", "table", "horizontal-rule", "clean-block", "|",
      "link", "image", "|",
      "preview", "side-by-side", "fullscreen",
    ],
    spellChecker: false,
    element: document.getElementById("markdown") 
  });
});
