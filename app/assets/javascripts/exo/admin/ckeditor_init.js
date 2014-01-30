//= require ./ckeditor_path.js
//= require ckeditor/ckeditor
//= require_self

$(document).ready(function(){
  CKEDITOR.config.filebrowserUploadUrl = '/admin/ckeditor_assets';
});
