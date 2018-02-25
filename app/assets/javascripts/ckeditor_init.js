var ready = function(e){
  if(typeof window.CKEDITOR !== "undefined" && typeof window.CKEDITOR.instances.question_content !== "undefined"){
    CKEDITOR.instances.question_content.destroy();
  }
  $('#question_content').each(function(){
    CKEDITOR.replace($(this).attr('id'));
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
