if(typeof CKEDITOR !== "undefined"){
  CKEDITOR.editorConfig = function(config){
    config.toolbar_mini = [
      [
        "Bold",
        "Italic",
        "Underline",
        "Strike",
        "-",
        "Subscript",
        "Superscript",
        "-",
        "Cut",
        "Copy",
        "Paste",
        "-",
        "Find",
        "Replace",
        "SelectAll",
        "-",
        "Styles",
        "Format",
        "Font",
        "TextColor"
      ]
    ];
    config.toolbar = "mini";
  }
}
